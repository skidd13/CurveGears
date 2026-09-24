#!/usr/bin/env python3
"""Emit one Doxydown module containing one function per test fixture."""

from pathlib import Path
import re
import sys


def leading_brief(source):
    lines = source.splitlines()
    comments = []
    in_block = False
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("/**"):
            in_block = True
            continue
        if in_block:
            if stripped.endswith("*/"):
                in_block = False
                continue
            stripped = re.sub(r"^\*\s?", "", stripped).strip()
        elif stripped.startswith("//"):
            stripped = stripped[2:].strip()
        else:
            if comments:
                break
            continue
        if not stripped or stripped.startswith("@"):  # metadata, not prose
            continue
        if stripped.startswith("http://") or stripped.startswith("https://"):
            continue
        comments.append(stripped)
        if not in_block:
            break
    return " ".join(comments)


def fallback_brief(path):
    title = path.stem.replace("_", " ")
    family = path.parent.name.replace("_", " ")
    return f"{family.capitalize()} {title} test case."


def main():
    print("/**")
    print(" * @module Test cases")
    print(" * @brief Executable regression and contract test fixtures.")
    print(" */")
    for path in sorted(Path("tests").rglob("*.scad")):
        relative = path.relative_to("tests").as_posix()
        identifier = "test_" + re.sub(r"[^A-Za-z0-9]+", "_", relative.removesuffix(".scad"))
        brief = leading_brief(path.read_text(encoding="utf-8")) or fallback_brief(path)
        print("/**")
        print(f" * @function {identifier}")
        print(f" * @brief [`{relative}`]({relative}) — {brief}")
        print(" */")
    return 0


if __name__ == "__main__":
    sys.exit(main())
