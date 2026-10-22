"""Check that Make's API example list covers every public SCAD callable."""
import argparse
from pathlib import Path
import re


PUBLIC = re.compile(r"^\s*(?:module|function)\s+(curve_gear_\w+)\s*\(", re.M)


def validate(examples, source_root):
    examples = list(examples)
    public = {
        name
        for path in Path(source_root).rglob('*.scad')
        for name in PUBLIC.findall(path.read_text())
    }
    canonical = {
        Path(path).stem
        for path in examples
        if '_alternative' not in Path(path).stem
    }
    missing = public - canonical
    unknown = canonical - public
    if missing or unknown:
        raise ValueError(f'API example mismatch: missing={sorted(missing)}, unknown={sorted(unknown)}')
    example_set = set(examples)
    for path in examples:
        if '_alternative' in Path(path).stem:
            normal = str(Path(path).with_name(Path(path).name.replace('_alternative', '')))
            if normal not in example_set:
                raise ValueError(f'alternative lacks canonical example: {path}')
    return examples


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source-root', default='src')
    parser.add_argument('examples', nargs='+')
    args = parser.parse_args()
    examples = validate(args.examples, args.source_root)
    print(f'PASS: all {len(examples)} API examples match the source-derived API inventory')


if __name__ == '__main__':
    main()
