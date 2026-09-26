#!/usr/bin/env python3
"""Validate regression outputs rendered by the Makefile.

The canonical suite is discovered from the test tree by Make. OpenSCAD
invocation and output ownership remain entirely in the Makefile; this script
only inspects the generated manifest, logs and STL results.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import subprocess

from .manifest import families as manifest_families
from .manifest import load as load_manifest
from .stl import assert_closed_mesh, compare_reference_tooth, sha


ROOT = Path(__file__).resolve().parents[2]
BUILD = ROOT / "build" / "regression"
SMOKE_MANIFEST = BUILD / "smoke_manifest.tsv"


DELIBERATE_CASES = {
    "tooth_placement": [
        (
            "tooth_validation_cases",
            ROOT / "tests/tooth/placement/validation_cases.scad",
            True,
            ["FRAME_NORMAL_REVERSED", "FLANK_CROSSING", "FLANK_ORDER_INVALID", "BODY_INTERSECTION_AMBIGUOUS", "POLYGON_SELF_INTERSECTION", "SPLICE_INTERVAL_OVERLAP", "SPLICE_INTERVAL_INTERLEAVED", "TOOTH_COLLISION_BROAD_PHASE", "TOOTH_TOP_OVERLAP", "TOOTH_ORDER_CONFLICT"],
        ),
        (
            "collision_failure",
            ROOT / "tests/tooth/placement/collision_failure.scad",
            False,
            ["TOOTH_COLLISION", "pair=0/1", "point="],
        ),
        (
            "polygon_failure",
            ROOT / "tests/tooth/placement/polygon_failure.scad",
            False,
            ["POLYGON_SELF_INTERSECTION", "segment=0/2", "point="],
        ),
    ],
    "tooth_generation": [
        (
            "tooth_equivalence",
            ROOT / "tests/tooth/generation/equivalence.scad",
            True,
            ["PASS: 72 tooth cases"],
        ),
    ],
    "superformula": [
        (
            "splice_validation",
            ROOT / "tests/superformula/mate_pipeline.scad",
            False,
            ["SPLICE_INTERVAL_INTERLEAVED"],
        ),
        (
            "accessibility_cases",
            ROOT / "tests/superformula/accessibility_cases.scad",
            True,
            ["SHALLOW_ACCESSIBLE", "DEEP_U_OMITTED", "DEEP_U_MIXED", "REMOTE_CORRIDOR_OBSTRUCTION"],
        ),
    ],
    "common_math": [],
    "mate_motion": [],
}

def _portable_result_metadata() -> dict:
    """Return reproducible result identity without machine-local paths."""
    commit = subprocess.run(["git", "rev-parse", "HEAD"], cwd=ROOT, capture_output=True, text=True, check=False)
    return {
        "renderer": "OpenSCAD",
        "renderer_owner": "Makefile",
        "repository_commit": commit.stdout.strip() if commit.returncode == 0 else "unavailable",
    }


def _read_render_log(output: Path) -> str:
    log = output.with_suffix(".log")
    assert log.exists(), f"missing Makefile render log: {log}"
    text = log.read_text()
    if "Incompatible processor" in text or "requires the following features" in text:
        raise RuntimeError(f"BLOCKED: OpenSCAD cannot execute on this host: {text.strip()}")
    return text


def _check_success_output(output: Path) -> str:
    text = _read_render_log(output)
    assert output.exists() and output.stat().st_size > 0, f"missing rendered output: {output}"
    assert not any(token in text for token in ("WARNING:", "ERROR:", "Parser error")), (output.name, text[-2000:])
    return text


def check_smoke(cases: list[tuple[str, Path, Path]], families: list[str]) -> list[dict]:
    rows = []
    references = {}
    for family, source, output in cases:
        if family not in families:
            continue
        _check_success_output(output)
        assert_closed_mesh(output)
        references[source.name] = output
        rows.append({"family": family, "name": str(source.relative_to(ROOT)), "output_sha256": sha(output)})
    if "common" in families and {"reference_pipeline.scad", "candidate_pipeline.scad"} <= references.keys():
        rows.append({
            "family": "common",
            **compare_reference_tooth(references["reference_pipeline.scad"], references["candidate_pipeline.scad"]),
        })
    return rows


def check_deliberate(families: list[str]) -> list[dict]:
    rows = []
    for family in families:
        for name, _source, expected_success, tokens in DELIBERATE_CASES.get(family, []):
            output = BUILD / f"{name}_deliberate.stl"
            log_text = _read_render_log(output)
            marker_suffix = "ok" if expected_success else "failed"
            marker = BUILD / f"{name}_deliberate.{marker_suffix}"
            assert marker.exists(), f"missing Makefile result marker: {marker}"
            if expected_success:
                assert output.exists() and output.stat().st_size > 0, f"missing deliberate output: {output}"
                assert not any(token in log_text for token in ("WARNING:", "ERROR:", "Parser error")), (name, log_text[-2000:])
            assert all(token in log_text for token in tokens), (name, "missing diagnostic", tokens, log_text[-2000:])
            rows.append({"family": family, "name": name, "expected_success": expected_success, "diagnostics": tokens})
    return rows


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--family", action="append", help="validate only this family; repeat for more than one")
    selection = parser.add_mutually_exclusive_group()
    selection.add_argument("--smoke-only", action="store_true", help="validate only successful smoke outputs")
    selection.add_argument("--deliberate-only", action="store_true", help="validate only deliberate diagnostic outputs")
    args = parser.parse_args()

    manifest = load_manifest(SMOKE_MANIFEST, ROOT)
    available_families = manifest_families(manifest, set(DELIBERATE_CASES))
    unknown_families = sorted(set(args.family or ()) - set(available_families))
    if unknown_families:
        parser.error("unknown family: " + ", ".join(unknown_families))
    BUILD.mkdir(parents=True, exist_ok=True)
    families = args.family or available_families
    smoke_rows = [] if args.deliberate_only else check_smoke(manifest, families)
    deliberate_rows = [] if args.smoke_only else check_deliberate(families)
    mode = "make-smoke" if args.smoke_only else "make-deliberate" if args.deliberate_only else "make-all"
    result = {
        "mode": mode,
        "families": families,
        **_portable_result_metadata(),
        "cases": smoke_rows,
        "deliberate_cases": deliberate_rows,
        "full_image_resolution": 4096,
        "ci_image_resolution": 1024,
    }
    (BUILD / "regression_results.json").write_text(json.dumps(result, indent=2) + "\n")
    print("PASS", len(smoke_rows), "smoke and", len(deliberate_rows), "deliberate", mode, "cases")


if __name__ == "__main__":
    try:
        main()
    except RuntimeError as error:
        raise SystemExit(str(error))
