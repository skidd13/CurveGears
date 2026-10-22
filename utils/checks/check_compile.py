"""Validate a Make-owned OpenSCAD compilation."""
import argparse
from pathlib import Path
import re

from .logs import clean_log


NUMERIC_SUFFIXES = ('_centre_distance', '_mate_rotation', '_reference_separation')


def check(output, source=''):
    output = Path(output)
    text = clean_log(output.with_suffix('.log'))
    if not output.is_file() or not output.stat().st_size:
        raise ValueError(f'missing/empty output: {output}')
    if Path(source).stem.endswith(NUMERIC_SUFFIXES):
        if 'ECHO:' not in text or re.search(r'\b(?:undef|nan|inf)\b', text, re.I):
            raise ValueError(f'invalid numeric example: {source}: {text}')
    elif not output.read_text().strip():
        raise ValueError(f'empty geometry compilation: {source}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output')
    parser.add_argument('--source', default='')
    args = parser.parse_args()
    check(args.output, args.source)


if __name__ == '__main__':
    main()
