"""Read the source-to-output manifest emitted by Make."""

from __future__ import annotations

from pathlib import Path
import os
import subprocess


def smoke_assignments(root: Path, build: Path) -> dict[Path, Path]:
    """Ask Make for its full catalogue without generating or rendering files."""
    result = subprocess.run(
        ['make', '-s', '--no-print-directory', '-f',
         str(Path(__file__).with_name('fixtures.mk').resolve()),
         'regression-smoke-manifest', f'REGRESSION_DIR={build.relative_to(root)}'],
        cwd=root, capture_output=True, text=True, check=True,
        env={key: value for key, value in os.environ.items()
             if key not in ('MAKEFLAGS', 'MFLAGS', 'MAKEOVERRIDES')})
    return {root / source: root / output for source, output in
            (line.split('\t') for line in result.stdout.splitlines())}


def source_family(relative: Path) -> str:
    """Classify any fixture by its owning shared responsibility or family."""
    family = relative.parts[0]
    if family == "common":
        return "common_math"
    if family == "tooth":
        return "_".join(relative.parts[:2])
    if family == "mate":
        return "mate_motion"
    return family


def load(path: Path, root: Path) -> list[tuple[str, Path, Path]]:
    """Load ``family, source, output`` assignments without rendering anything."""
    assert path.exists(), f"missing Makefile smoke manifest: {path}"
    cases = []
    sources = set()
    outputs = set()
    expected = smoke_assignments(root, path.parent)
    assert expected, 'empty canonical smoke catalogue'
    for line in path.read_text().splitlines():
        source_text, output_text = line.split("\t", 1)
        assert not Path(source_text).is_absolute(), f"absolute manifest source: {source_text}"
        source = root / source_text
        output = root / output_text
        assert source not in sources, f"duplicate manifest source: {source}"
        assert output not in outputs, f"duplicate manifest output: {output}"
        assert source.exists() and source.suffix == ".scad", f"invalid manifest source: {source}"
        assert not Path(output_text).is_absolute(), f"absolute manifest output: {output}"
        assert source in expected, f"noncanonical smoke source or role: {source}"
        assert output == expected[source], f"wrong smoke output or tier: {source}: {output}"
        sources.add(source)
        outputs.add(output)
        relative = source.relative_to(root / "tests")
        family = source_family(relative)
        cases.append((family, source, output))
    assert sources == set(expected), f"missing canonical smoke cases: {sorted(set(expected) - sources)}"
    return cases


def families(cases: list[tuple[str, Path, Path]], deliberate: set[str]) -> list[str]:
    """Return the available family names in stable order."""
    return sorted({family for family, _source, _output in cases} | deliberate)
