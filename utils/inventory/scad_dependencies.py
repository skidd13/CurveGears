"""Resolve transitive SCAD includes for Make-owned generated outputs."""
from pathlib import Path
import argparse
import re

from ..build.write_if_changed import write_if_changed


ROOT = Path(__file__).resolve().parents[2]
SLASH = chr(47)
TOKEN = re.compile(SLASH + r'\*.*?\*' + SLASH + '|' + SLASH * 2 +
                   r'[^\n]*|"(?:\\.|[^"\\])*"|\b(?:use|include)\s*<([^>]+)>', re.S)


def dependencies(source, root=ROOT):
    root = root.resolve()
    seen = set()

    def visit(path):
        path = path.resolve()
        if path in seen:
            return
        if not path.is_file():
            raise ValueError(f'missing OpenSCAD dependency: {path}')
        seen.add(path)
        for token in TOKEN.finditer(path.read_text()):
            if token.group(1):
                visit(path.parent / token.group(1))

    visit(root / source)
    return sorted(path.relative_to(root).as_posix() for path in seen)


def dependency_rules(examples, tests, regression_dir='build/regression'):
    rows = []
    for source in examples:
        relative = source.removeprefix('examples/').removesuffix('.scad')
        targets = f'images/{relative}.png build/ci-images/{relative}.png build/ci-images/{relative}.csg'
        rows.append(f'{targets}: {" ".join(dependencies(source))}\n')
    for source in tests:
        relative = source.removeprefix('tests/').removesuffix('.scad')
        targets = f'{regression_dir}/smoke/{relative}.stl {regression_dir}/smoke/{relative}.csg {regression_dir}/invalid/{relative}.failed'
        if Path(source).name == 'full_pipeline.scad':
            targets += f' {regression_dir}/full_{Path(source).parent.name}.stl'
        rows.append(f'{targets}: {" ".join(dependencies(source))}\n')
    return ''.join(rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('sources', nargs='*', help='print dependencies for these SCAD sources')
    parser.add_argument('--output', help='write Make dependency rules for Make-supplied sources')
    parser.add_argument('--regression-dir', default='build/regression')
    parser.add_argument('--examples', nargs='*', default=[])
    parser.add_argument('--tests', nargs='*', default=[])
    args = parser.parse_args()
    if args.sources:
        print(' '.join(sorted({dependency for source in args.sources
                               for dependency in dependencies(source)})))
    elif args.output:
        write_if_changed(args.output, dependency_rules(args.examples, args.tests, args.regression_dir))
    else:
        parser.error('provide source paths or --output')


if __name__ == '__main__':
    main()
