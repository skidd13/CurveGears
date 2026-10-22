"""Validate a collision probe that is expected to produce no STL."""
import argparse
from pathlib import Path

from .logs import clean_log


def check(output):
    output = Path(output)
    text = clean_log(output.with_suffix('.log'))
    if 'Current top level object is empty.' not in text or output.exists():
        raise ValueError(f'collision probe is not empty: {output}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output')
    args = parser.parse_args()
    check(args.output)


if __name__ == '__main__':
    main()
