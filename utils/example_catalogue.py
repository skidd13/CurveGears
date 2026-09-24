#!/usr/bin/env python3
"""Emit one Doxydown module containing one function per executable example."""

from pathlib import Path
import re
import sys


def documentation(source):
    blocks = re.findall(r"/\*\*.*?\*/", source, re.DOTALL)
    for block in blocks:
        name = re.search(r"@(?:file|module)\s+(.+)", block)
        brief = re.search(r"@brief\s+(.+)", block)
        if name or brief:
            return (name.group(1).strip() if name else "", brief.group(1).strip() if brief else "")
    for line in source.splitlines():
        match = re.match(r"\s*//\s*(\S.+)", line)
        if match and not match.group(1).startswith("@"):
            return "", match.group(1).strip()
    return "", ""


def fallback_brief(path):
    return f"Executable example for {path.stem.replace('_', ' ')}."


def example_paths():
    api = sorted(Path("examples/functions").rglob("*.scad"))
    core = [Path("examples") / name for name in ("tooth/construction.scad", "tooth/placement.scad", "tooth/assembly.scad")]
    return api + core


def main():
    print("/**")
    print(" * @module Executable examples")
    print(" * @brief Executable examples for the public API and shared construction layers.")
    print(" */")
    for path in example_paths():
        relative = path.relative_to("examples").as_posix()
        identifier = "example_" + re.sub(r"[^A-Za-z0-9]+", "_", relative.removesuffix(".scad"))
        title, brief = documentation(path.read_text(encoding="utf-8"))
        brief = brief or fallback_brief(path)
        label = title or path.stem.replace("_", " ")
        print("/**")
        print(f" * @function {identifier}")
        print(f" * @brief [`{relative}`]({relative}) — {label}: {brief}")
        image = Path("images") / Path(relative).with_suffix(".png")
        if image.is_file():
            image_relative = Path("..") / image
            print(f" * @image {image_relative.as_posix()} {label} preview")
        print(" */")
    return 0


if __name__ == "__main__":
    sys.exit(main())
