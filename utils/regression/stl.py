"""STL parsing and geometry assertions for regression outputs."""

from __future__ import annotations

import hashlib
import math
from pathlib import Path
import re
import struct


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _triangles(path: Path) -> list[tuple[tuple[float, float, float], ...]]:
    data = path.read_bytes()
    if len(data) >= 84:
        count = struct.unpack_from("<I", data, 80)[0]
        if 84 + 50 * count == len(data):
            triangles = []
            for index in range(count):
                offset = 84 + index * 50 + 12
                vertices = tuple(
                    struct.unpack_from("<3f", data, offset + vertex * 12)
                    for vertex in range(3)
                )
                triangles.append(vertices)
            return triangles
    text = data.decode("ascii")
    vertices = [tuple(float(value) for value in match.groups()) for match in re.finditer(
        r"vertex\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)", text
    )]
    assert len(vertices) % 3 == 0, f"invalid STL vertex count: {path}"
    return [tuple(vertices[index:index + 3]) for index in range(0, len(vertices), 3)]


def metrics(path: Path) -> dict:
    triangles = _triangles(path)
    assert triangles, f"empty STL: {path}"
    vertices = [vertex for triangle in triangles for vertex in triangle]
    bounds = tuple(
        (min(vertex[axis] for vertex in vertices), max(vertex[axis] for vertex in vertices))
        for axis in range(3)
    )
    surface_area = 0.0
    signed_volume = 0.0
    edge_counts: dict[tuple[tuple[float, float, float], tuple[float, float, float]], int] = {}
    for a, b, c in triangles:
        ab = tuple(b[index] - a[index] for index in range(3))
        ac = tuple(c[index] - a[index] for index in range(3))
        cross = (
            ab[1] * ac[2] - ab[2] * ac[1],
            ab[2] * ac[0] - ab[0] * ac[2],
            ab[0] * ac[1] - ab[1] * ac[0],
        )
        surface_area += math.sqrt(sum(component * component for component in cross)) / 2
        signed_volume += (
            a[0] * (b[1] * c[2] - b[2] * c[1])
            - a[1] * (b[0] * c[2] - b[2] * c[0])
            + a[2] * (b[0] * c[1] - b[1] * c[0])
        ) / 6
        for first, second in ((a, b), (b, c), (c, a)):
            edge = tuple(sorted((tuple(round(value, 6) for value in first), tuple(round(value, 6) for value in second))))
            edge_counts[edge] = edge_counts.get(edge, 0) + 1
    return {
        "triangles": len(triangles),
        "bounds": bounds,
        "spans": tuple(high - low for low, high in bounds),
        "surface_area": surface_area,
        "volume": abs(signed_volume),
        "closed": all(count == 2 for count in edge_counts.values()),
    }


def _metrics_close(expected: float, actual: float, relative_tolerance: float = 1e-5) -> bool:
    tolerance = relative_tolerance * max(abs(expected), abs(actual), 1.0)
    return abs(expected - actual) <= tolerance


def compare_reference_tooth(reference: Path, candidate: Path) -> dict:
    expected = metrics(reference)
    actual = metrics(candidate)
    assert expected["closed"] and actual["closed"], "reference/candidate tooth mesh is not closed"
    assert expected["triangles"] == actual["triangles"], "reference/candidate triangle count changed"
    assert abs(expected["spans"][2] - actual["spans"][2]) <= 1e-5, "reference/candidate height changed"
    expected_xy = sorted(expected["spans"][:2])
    actual_xy = sorted(actual["spans"][:2])
    assert all(abs(left - right) <= 2e-2 for left, right in zip(expected_xy, actual_xy)), \
        ("reference/candidate XY envelope changed", expected_xy, actual_xy)
    assert _metrics_close(expected["surface_area"], actual["surface_area"]), \
        ("reference/candidate surface area changed", expected["surface_area"], actual["surface_area"])
    assert _metrics_close(expected["volume"], actual["volume"]), \
        ("reference/candidate volume changed", expected["volume"], actual["volume"])
    return {
        "name": "reference_vs_candidate_tooth_stl",
        "triangles": actual["triangles"],
        "surface_area": actual["surface_area"],
        "volume": actual["volume"],
    }


def assert_closed_mesh(output: Path, expected_height: float | None = None) -> dict:
    result = metrics(output)
    assert result["closed"], f"MESH_NONMANIFOLD: non-manifold or open mesh: {output}"
    if expected_height is not None:
        assert abs(result["spans"][2] - expected_height) <= 1e-5, \
            ("EXTRUSION_HEIGHT_INVALID", output.name, result["spans"][2], expected_height)
    return result
