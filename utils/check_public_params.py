#!/usr/bin/env python3
"""Check that public CurveGears signatures and Doxygen parameters agree."""

from pathlib import Path
import re
import sys


DECLARATION = re.compile(
    r"(?m)^\s*(?:module|function)\s+(curve_gear_[A-Za-z0-9_]+)\s*\("
)
PARAMETER = re.compile(r"@param\s+([A-Za-z_][A-Za-z0-9_]*)")
FUNCTION_TAG = re.compile(r"@function\s+(curve_gear_[A-Za-z0-9_]+)")


def split_arguments(arguments):
    result = []
    start = 0
    square = round_ = curly = 0
    for index, character in enumerate(arguments):
        if character == "[":
            square += 1
        elif character == "]":
            square -= 1
        elif character == "(":
            round_ += 1
        elif character == ")":
            round_ -= 1
        elif character == "{":
            curly += 1
        elif character == "}":
            curly -= 1
        elif character == "," and not (square or round_ or curly):
            result.append(arguments[start:index].strip())
            start = index + 1
    result.append(arguments[start:].strip())
    return result


def declaration_arguments(source, position):
    opening = source.find("(", position)
    depth = 0
    for index in range(opening, len(source)):
        if source[index] == "(":
            depth += 1
        elif source[index] == ")":
            depth -= 1
            if depth == 0:
                return split_arguments(source[opening + 1:index])
    raise ValueError("unterminated public declaration")


def public_documentation(source):
    documentation = {}
    for block in re.finditer(r"/\*\*.*?\*/", source, re.DOTALL):
        text = block.group()
        for name in FUNCTION_TAG.findall(text):
            documentation[name] = text
    return documentation


def check_file(path):
    source = path.read_text(encoding="utf-8")
    documentation = public_documentation(source)
    findings = []
    for declaration in DECLARATION.finditer(source):
        name = declaration.group(1)
        arguments = []
        for argument in declaration_arguments(source, declaration.start()):
            match = re.match(r"([A-Za-z_][A-Za-z0-9_]*)", argument)
            if match:
                arguments.append(match.group(1))
        documented = list(dict.fromkeys(PARAMETER.findall(documentation.get(name, ""))))
        missing = [name for name in arguments if name not in documented]
        extra = [name for name in documented if name not in arguments]
        if missing or extra or name not in documentation:
            line = source.count("\n", 0, declaration.start()) + 1
            findings.append((path, line, name, missing, extra, name not in documentation))
    return findings


def main():
    findings = []
    for path in sorted(Path("src").rglob("*.scad")):
        findings.extend(check_file(path))
    if findings:
        for path, line, name, missing, extra, no_block in findings:
            print(
                f"{path}:{line}: {name}: missing={missing} extra={extra} "
                f"no_block={no_block}"
            )
        return 1
    print("PASS: public CurveGears signatures and Doxygen parameters agree")
    return 0


if __name__ == "__main__":
    sys.exit(main())
