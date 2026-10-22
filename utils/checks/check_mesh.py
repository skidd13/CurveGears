"""Validate that an exported STL mesh is closed."""
import argparse
from pathlib import Path

from .logs import clean_log
from ..regression.stl import assert_closed_mesh


def check(output):
    output = Path(output)
    clean_log(output.with_suffix('.log'))
    if not output.is_file() or not output.stat().st_size:
        raise ValueError(f'missing/empty output: {output}')
    return assert_closed_mesh(output)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output')
    args = parser.parse_args()
    check(args.output)


if __name__ == '__main__':
    main()
