"""Materialise an OpenSCAD state snapshot from a native envelope render log."""
import argparse
import json
import math
import os
from pathlib import Path
from .build_inventory import ROOT, write_if_changed
from .check_build_output import clean_log


def snapshot(log, output):
    records = []
    for line in clean_log(log).splitlines():
        if line.startswith('ECHO: "CUSP_CACHE_JSON:'):
            records.append(json.loads(json.loads(line[6:]).removeprefix('CUSP_CACHE_JSON:')))
    if len(records) != 1:
        raise ValueError('expected one native Cusp state snapshot')
    distance, outline, motion = records[0]
    if not math.isfinite(distance) or distance <= 0 or len(outline) < 3 or len(motion) < 120:
        raise ValueError('incomplete native Cusp state snapshot')
    for points in (outline, motion):
        if any(len(point) != 2 or not all(math.isfinite(v) for v in point) for point in points):
            raise ValueError('invalid native Cusp snapshot coordinates')
    include = os.path.relpath(ROOT / 'tests/cusp/envelope_solver_collision_probe.scad', Path(output).resolve().parent)
    text = (f'cached_distance={json.dumps(distance)};\n'
            f'cached_driver_outline={json.dumps(outline)};\n'
            f'cached_motion={json.dumps(motion)};\n'
            f'include <{include}>\n')
    write_if_changed(output, text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('log')
    parser.add_argument('output')
    args = parser.parse_args()
    snapshot(args.log, args.output)


if __name__ == '__main__':
    main()
