"""Validate that an exported DXF profile is finite and closed."""
import argparse
from collections import Counter
import math
from pathlib import Path

from .logs import clean_log


def closed_dxf(output):
    lines = output.read_text().splitlines()
    if len(lines) % 2:
        raise ValueError(f"invalid DXF group pairs: {output}")
    entities = []
    current = []
    in_entities = False
    for code, value in zip(lines[::2], lines[1::2]):
        code, value = int(code.strip()), value.strip()
        if code == 2 and value == "ENTITIES":
            in_entities = True
        elif in_entities and code == 0:
            if current:
                entities.append(current)
            current = [] if value == "ENDSEC" else [(code, value)]
            if value == "ENDSEC":
                in_entities = False
        elif in_entities:
            current.append((code, value))
    degrees = Counter()
    for entity in entities:
        fields = dict(entity[1:])
        if entity[0] == (0, "LINE"):
            edges = [((float(fields[10]), float(fields[20])),
                      (float(fields[11]), float(fields[21])))]
        elif entity[0] == (0, "LWPOLYLINE"):
            vertices = []
            x = None
            for code, value in entity[1:]:
                if code == 10:
                    x = float(value)
                elif code == 20:
                    if x is None:
                        raise ValueError("DXF vertex lacks x coordinate")
                    vertices.append((x, float(value)))
                    x = None
                elif code == 42 and float(value) != 0:
                    raise ValueError("curved DXF edges cannot represent the sampled outline")
            if not int(fields.get(70, 0)) & 1 or len(vertices) != int(fields[90]):
                raise ValueError(f"open or incomplete DXF polyline: {output}")
            edges = list(zip(vertices, vertices[1:] + vertices[:1]))
        else:
            raise ValueError(f"unsupported DXF entity: {entity[0]}")
        for a, b in edges:
            if not all(math.isfinite(value) for value in (*a, *b)):
                raise ValueError(f"invalid DXF edge: {output}")
            if a != b:
                degrees.update((a, b))
    if len(degrees) < 3 or any(value != 2 for value in degrees.values()):
        raise ValueError(f"open or non-manifold DXF outline: {output}")


def check(output):
    output = Path(output)
    clean_log(output.with_suffix('.profile.log'))
    if not output.is_file() or not output.stat().st_size:
        raise ValueError(f'missing/empty output: {output}')
    closed_dxf(output)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output')
    args = parser.parse_args()
    check(args.output)


if __name__ == '__main__':
    main()
