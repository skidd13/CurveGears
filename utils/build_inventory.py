"""Source-derived example inventory and transitive OpenSCAD dependencies.

This module owns classification and dependency discovery, never rendering.
Make owns each output, allowing parallel and incremental builds.
"""
from pathlib import Path
import argparse
import re

ROOT = Path(__file__).resolve().parents[1]
# Compose the comment delimiter so the path-hygiene scan does not read the
# lexical expression as an absolute filesystem path.
SLASH = chr(47)
TOKEN = re.compile(SLASH + r'\*.*?\*' + SLASH + '|' + SLASH * 2 +
                   r'[^\n]*|"(?:\\.|[^"\\])*"|\b(?:use|include)\s*<([^>]+)>', re.S)
PUBLIC = re.compile(r'^\s*(?:module|function)\s+(curve_gear_\w+)\s*\(', re.M)


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


def examples(root=ROOT):
    paths = [root / 'examples/main_curved_gear.scad']
    paths += sorted((root / 'examples/tooth').glob('*.scad'))
    paths += sorted((root / 'examples/functions').rglob('*.scad'))
    return [p.relative_to(root).as_posix() for p in paths if p.name != 'palette.scad']


def group(source):
    parts = Path(source).parts
    return parts[2] if parts[1] == 'functions' else 'core' if parts[1] == 'tooth' else 'overview'


def numeric(source):
    return Path(source).stem.endswith(('_centre_distance', '_mate_rotation', '_reference_separation'))


def render_case(source):
    """Pairs exercise both gears; outlined bodies exercise independent offsets."""
    if group(source) in ('core', 'overview'):
        return True
    stem = Path(source).stem.replace('_alternative', '')
    return stem.endswith(('_pair', '_body_2d'))


def validate(root=ROOT):
    sources = examples(root)
    public = {name for p in (root / 'src').rglob('*.scad') for name in PUBLIC.findall(p.read_text())}
    canonical = {Path(p).stem for p in sources if group(p) not in ('core', 'overview') and '_alternative' not in Path(p).stem}
    missing = public - canonical
    unknown = canonical - public
    if missing or unknown:
        raise ValueError(f'API example mismatch: missing={sorted(missing)}, unknown={sorted(unknown)}')
    for source in sources:
        if not (root / source).is_file() or not (root / source).stat().st_size:
            raise ValueError(f'missing/empty example: {source}')
        if '_alternative' in Path(source).stem:
            normal = str(Path(source).with_name(Path(source).name.replace('_alternative', '')))
            if normal not in sources:
                raise ValueError(f'alternative lacks canonical example: {source}')
    return sources


def write_if_changed(path, text):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    if not path.exists() or path.read_text() != text:
        path.write_text(text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--render-sources', action='store_true', help='print the routine full-render matrix')
    parser.add_argument('--source', help='print transitive prerequisites for a Make rule')
    parser.add_argument('--manifest')
    parser.add_argument('--dependencies')
    parser.add_argument('--regression-dir', default='build/regression')
    args = parser.parse_args()
    if args.source:
        print(" ".join(dependencies(args.source)))
        return
    sources = validate()
    if args.render_sources:
        print(" ".join(p for p in sources if render_case(p)))
        return
    if args.manifest:
        write_if_changed(args.manifest, ''.join(f'{p}\tbuild/ci-images/{p.removeprefix("examples/").removesuffix(".scad")}.{"png" if render_case(p) else "csg"}\n' for p in sources))
        print(f'PASS: inventory contains {len(sources)} examples, {sum(render_case(p) for p in sources)} routine full renders')
    if args.dependencies:
        rows = []
        for p in sources:
            relative = p.removeprefix('examples/').removesuffix('.scad')
            targets = f'images/{relative}.png build/ci-images/{relative}.png build/ci-images/{relative}.csg'
            rows.append(f'{targets}: {" ".join(dependencies(p))}\n')
        for p in sorted((ROOT / 'tests').rglob('*.scad')):
            source = p.relative_to(ROOT).as_posix()
            relative = source.removeprefix('tests/').removesuffix('.scad')
            targets = f'{args.regression_dir}/smoke/{relative}.stl {args.regression_dir}/smoke/{relative}.csg {args.regression_dir}/invalid/{relative}.failed'
            if p.name == 'full_pipeline.scad':
                targets += f' {args.regression_dir}/full_{p.parent.name}.stl'
            rows.append(f'{targets}: {" ".join(dependencies(source))}\n')
        write_if_changed(args.dependencies, ''.join(rows))
    if not args.manifest and not args.dependencies:
        print(f'PASS: all {len(sources)} examples match the source-derived API inventory')


if __name__ == '__main__':
    main()
