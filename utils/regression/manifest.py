"""Read the source-to-output manifest emitted by Make."""

from __future__ import annotations

from pathlib import Path


def load(path: Path, root: Path) -> list[tuple[str, Path, Path]]:
    """Load ``family, source, output`` assignments without rendering anything."""
    assert path.exists(), f"missing Makefile smoke manifest: {path}"
    cases = []
    sources = set()
    outputs = set()
    for line in path.read_text().splitlines():
        source_text, output_text = line.split("\t", 1)
        source = root / source_text
        output = root / output_text
        assert source not in sources, f"duplicate manifest source: {source}"
        assert output not in outputs, f"duplicate manifest output: {output}"
        assert source.exists() and source.suffix == ".scad", f"invalid manifest source: {source}"
        assert not Path(output_text).is_absolute(), f"absolute manifest output: {output}"
        sources.add(source)
        outputs.add(output)
        relative = source.relative_to(root / "tests")
        family = relative.parts[0]
        if family == "common":
            family = "common_math"
        elif family == "tooth":
            family = "_".join(relative.parts[:2])
        elif family == "mate":
            family = "mate_motion"
        cases.append((family, source, output))
    return cases


def families(cases: list[tuple[str, Path, Path]], deliberate: set[str]) -> list[str]:
    """Return the available family names in stable order."""
    return sorted({family for family, _source, _output in cases} | deliberate)
