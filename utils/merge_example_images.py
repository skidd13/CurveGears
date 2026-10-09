#!/usr/bin/env python3
"""Insert example-owned image panels into generated API documentation pages."""

from pathlib import Path
import re
import sys


IMAGE_RE = re.compile(r"@image\s+(\.\./images/[^\s]+)\s+(.+?)\s*$")
FUNCTION_RE = re.compile(r"@function\s+(\S+)")
HEADING_RE = re.compile(r"^### Function `([^`]+)`$")
SPECIAL_STEMS = {
    "construction_2d": "_cg_reference_tooth_candidate",
    "construction_alternative_2d": "_cg_reference_tooth_candidate",
    "placement": "_cg_placement_result",
    "placement_alternative": "_cg_placement_result",
}
FAMILY_NAMES = {
    "bezier": "Bézier",
    "cassini": "Cassini",
    "circle": "Circle",
    "cosine_quintic": "Cosine Quintic",
    "cusp": "Cusp",
    "ellipse": "Ellipse",
    "epitrochoid": "Epitrochoid",
    "fourier": "Fourier",
    "hypotrochoid": "Hypotrochoid",
    "lobed": "Lobed",
    "logarithmic_spiral": "Logarithmic Spiral",
    "logistic_dwell": "Logistic Dwell",
    "pascal": "Pascal",
    "superformula": "Superformula",
    "tanh_triad": "Tanh Triad",
    "temple_fay": "Temple Fay",
}


def panel_label(stem: str, entries: list[tuple[str, str]]) -> str:
    if stem == "_cg_reference_tooth_candidate":
        return "Tooth construction"
    if stem == "_cg_placement_result":
        return "Tooth placement"
    if not stem.startswith("curve_gear_"):
        return entries[0][1].removesuffix(" alternative").removesuffix(" 1")
    rest = stem.removeprefix("curve_gear_")
    family = next((name for key, name in FAMILY_NAMES.items() if rest == key or rest.startswith(key + "_")), None)
    if family is None:
        return entries[0][1].removesuffix(" alternative").removesuffix(" 1")
    suffix = rest[len(next(key for key in FAMILY_NAMES if rest == key or rest.startswith(key + "_"))):]
    descriptors = {
        "": "gear",
        "_2d": "2D gear",
        "_body": "body",
        "_body_2d": "2D body",
        "_mate": "mate",
        "_pair": "pair",
    }
    return f"{family} {descriptors.get(suffix, suffix.strip('_').replace('_', ' '))}".strip()


def image_panels(root: Path) -> dict[str, list[tuple[str, str]]]:
    panels: dict[str, list[tuple[str, str]]] = {}
    for source in sorted((root / "examples").rglob("*.scad")):
        function = None
        for line in source.read_text().splitlines():
            match = FUNCTION_RE.search(line)
            if match:
                function = match.group(1)
            match = IMAGE_RE.search(line)
            if not match:
                continue
            path, alt = match.groups()
            stem = SPECIAL_STEMS.get(
                Path(path).stem,
                re.sub(r"_alternative(?=_2d|$)", "", Path(path).stem),
            )
            panels.setdefault(stem, []).append((path, alt))
    return panels


def merge(page: Path, panels: dict[str, list[tuple[str, str]]]) -> None:
    lines = page.read_text().splitlines()
    output: list[str] = []
    for line in lines:
        output.append(line)
        match = HEADING_RE.match(line)
        if not match or match.group(1) not in panels:
            continue
        entries = panels[match.group(1)]
        entries = list({path: (path, alt) for path, alt in entries}.values())
        label = panel_label(match.group(1), entries)
        headers = [f"{label} {index}" for index in range(1, len(entries) + 1)]
        output.extend(("", "| " + " | ".join(headers) + " |"))
        output.append("| " + " | ".join("---" for _ in entries) + " |")
        output.append(
            "| "
            + " | ".join(
                f"[![{alt}]({path})]({path})" for path, alt in entries
            )
            + " |"
        )
    page.write_text("\n".join(output) + "\n")


def main() -> int:
    if len(sys.argv) < 2:
        raise SystemExit("usage: merge_example_images.py DOC_PAGE [...]")
    root = Path(__file__).resolve().parent.parent
    panels = image_panels(root)
    for name in sys.argv[1:]:
        merge(Path(name), panels)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
