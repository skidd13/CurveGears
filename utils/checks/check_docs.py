#!/usr/bin/env python3
"""Check source documentation contracts and Markdown module boundaries."""

from pathlib import Path
import re
import sys


DECLARATION = re.compile(
    r"(?m)^\s*(module|function)\s+([A-Za-z_][A-Za-z0-9_]*)\s*\("
)
DOC_BLOCK = re.compile(r"/\*{2,}.*?\*/", re.DOTALL)
PARAMETER = re.compile(
    r"(?m)^\s*\*?\s*@param\s+([A-Za-z_][A-Za-z0-9_]*)"
    r"(?:\s+\{([^}]*)\})?\s*(.*)$"
)
MODULE_HEADING = re.compile(r"(?m)^## Module(?:\s|$)")
PUBLIC_PREFIX = "curve_gear_"


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
    raise ValueError("unterminated source declaration")


def _default_value(argument):
    match = re.match(r"([A-Za-z_][A-Za-z0-9_]*)\s*(?:=(.*))?$", argument.strip())
    return (match.group(1), match.group(2).strip() if match and match.group(2) else None) if match else (None, None)


def _canonical_value(value):
    value = re.sub(r"\s+", "", value)
    if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
        value = value[1:-1]
    if re.fullmatch(r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?", value):
        return format(float(value), ".15g")
    return value


def _direct_documentation(source, declaration, blocks):
    preceding = [block for block in blocks if block.end() <= declaration.start()]
    if not preceding:
        return None
    block = preceding[-1]
    return block if not source[block.end():declaration.start()].strip() else None


def check_source_text(source, path="<source>"):
    findings = []
    blocks = list(DOC_BLOCK.finditer(source))
    for declaration in DECLARATION.finditer(source):
        kind, name = declaration.groups()
        line = source.count("\n", 0, declaration.start()) + 1
        block = _direct_documentation(source, declaration, blocks)
        public = name.startswith(PUBLIC_PREFIX)
        if block is None and (kind == "function" or public):
            findings.append(f"{path}:{line}: {name}: missing adjacent documentation entry")
            continue
        if block is None:
            continue
        text = block.group()
        tag = re.search(r"@(function|module)\s+([A-Za-z_][A-Za-z0-9_]*)", text)
        if (kind == "function" or public) and (not tag or tag.group(2) != name):
            findings.append(f"{path}:{line}: {name}: documentation entry must name this declaration")
            continue

        if public:
            function_tag = re.search(r"@function\s+([A-Za-z_][A-Za-z0-9_]*)", text)
            if not function_tag or function_tag.group(1) != name:
                findings.append(f"{path}:{line}: {name}: public entry must use a parameterless @function name")
            if not re.search(r"(?m)^\s*\*?\s*@brief\s+\S", text):
                findings.append(f"{path}:{line}: {name}: missing non-empty @brief")

        arguments = [_default_value(argument) for argument in declaration_arguments(source, declaration.start())]
        arguments = [(parameter, default) for parameter, default in arguments if parameter]
        if public:
            documented = {}
            for parameter in PARAMETER.finditer(text):
                documented.setdefault(parameter.group(1), []).append(parameter)
            expected = {parameter for parameter, _ in arguments}
            actual = set(documented)
            for missing in sorted(expected - actual):
                findings.append(f"{path}:{line}: {name}: missing @param {missing}")
            for extra in sorted(actual - expected):
                findings.append(f"{path}:{line}: {name}: undocumented @param {extra}")
            for parameter, default in arguments:
                entries = documented.get(parameter, [])
                if len(entries) != 1:
                    if len(entries) > 1:
                        findings.append(f"{path}:{line}: {name}: duplicate @param {parameter}")
                    continue
                spec = entries[0].group(2) or ""
                type_spec, separator, documented_default = spec.partition(", default ")
                if not type_spec.strip():
                    findings.append(f"{path}:{line}: {name}: @param {parameter} is missing its type")
                if default is not None:
                    if not separator:
                        findings.append(f"{path}:{line}: {name}: @param {parameter} is missing its default")
                    elif _canonical_value(default) != _canonical_value(documented_default):
                        findings.append(
                            f"{path}:{line}: {name}: @param {parameter} default "
                            f"{documented_default!r} does not match signature {default!r}"
                        )
        if public and kind == "function" and not re.search(r"(?m)^\s*\*?\s*@return\s+\{[^}]+\}\s+\S", text):
            findings.append(f"{path}:{line}: {name}: function requires a typed @return")
    return findings


def check_file(path):
    return check_source_text(path.read_text(encoding="utf-8"), path.as_posix())


def check_markdown_modules(root):
    excluded = {".git", ".codex", ".agents", "build"}
    findings = []
    for path in sorted(root.rglob("*.md")):
        if excluded.intersection(path.relative_to(root).parts):
            continue
        count = len(MODULE_HEADING.findall(path.read_text(encoding="utf-8")))
        if count > 1:
            findings.append(f"{path.relative_to(root)}: has {count} module sections; expected at most one")
    return findings


def main():
    root = Path.cwd()
    findings = []
    for path in sorted((root / "src").rglob("*.scad")):
        findings.extend(check_file(path))
    findings.extend(check_markdown_modules(root))
    if findings:
        print("\n".join(findings))
        return 1
    print("PASS: source documentation contracts and Markdown module boundaries agree")
    return 0


if __name__ == "__main__":
    sys.exit(main())
