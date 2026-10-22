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
PAIR_CALL = re.compile(r"curve_gear_[a-z0-9_]+_pair\(([^;]+)\);")
VIEW_CALL = re.compile(r"curve_gear_[a-z0-9_]+_(pair|body|mate)\(([^;]+)\);")
TWO_D_CALL = re.compile(r"curve_gear_[a-z0-9_]+(?:_body)?_2d\(([^;]+)\);")


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


def positional_prefix(arguments):
    values = []
    for argument in arguments.split(","):
        if "=" in argument:
            break
        values.append(argument.strip())
    return values


def dimensions(arguments, path):
    values = positional_prefix(arguments)
    if len(values) < 4:
        raise SystemExit(f"{path}: pair view has fewer than four geometry arguments")
    return tuple(values[2:4])


def call_arguments(path, function_name):
    match = re.search(rf"{re.escape(function_name)}\(([^;]+)\);", path.read_text())
    if not match:
        raise SystemExit(f"{path}: missing {function_name} call")
    return match.group(1)


def check_pair_examples(root):
    normal = sorted((root / "examples/functions").glob("*/curve_gear_*_pair.scad"))
    if len(normal) != 16:
        raise SystemExit(f"expected 16 normal pair examples, found {len(normal)}")
    for path in normal:
        text = path.read_text()
        match = PAIR_CALL.search(text)
        if not match:
            family = path.parent.name
            selected = re.search(rf'_main_example_{re.escape(family)}_view\("pair"\)', text)
            owner = path.with_name(f"curve_gear_{family}.scad")
            if not selected or not owner.exists() or "together_built=true" not in owner.read_text():
                raise SystemExit(f"{path}: missing direct pair call or canonical engaged owner")
            continue
        if "together_built=true" not in match.group(1):
            raise SystemExit(f"{path}: pair call is not explicitly engaged")
        dimensions(match.group(1), path)
    for pair in normal:
        family = pair.parent.name
        if any(
            f'_main_example_{family}_view("{view}")' in path.read_text()
            for view in ("pair", "body", "mate")
            for path in (pair.parent / f"curve_gear_{family}_{view}.scad",)
            if path.exists()
        ):
            continue
        views = {}
        for view in ("pair", "body", "mate"):
            path = pair.parent / f"curve_gear_{family}_{view}.scad"
            if path.exists():
                views[view] = dimensions(call_arguments(path, f"curve_gear_{family}_{view}"), path)
        if len(views) == 3 and len(set(views.values())) != 1:
            raise SystemExit(f"{pair.parent}: normal pair/body/mate dimensions differ: {views}")

    alternatives = sorted((root / "examples/functions").glob("*/curve_gear_*_alternative.scad"))
    wrappers = [path for path in alternatives if not any(
        marker in path.name for marker in ("_pair_alternative", "_body_alternative", "_mate_alternative")
    )]
    if len(wrappers) != 16:
        raise SystemExit(f"expected 16 alternative wrappers, found {len(wrappers)}")
    for path in wrappers:
        text = path.read_text()
        views = list(VIEW_CALL.finditer(text))
        if {match.group(1) for match in views} != {"pair", "body", "mate"}:
            raise SystemExit(f"{path}: expected pair, body and mate calls")
        if not any("together_built=true" in match.group(2) for match in views if match.group(1) == "pair"):
            raise SystemExit(f"{path}: alternative pair call is not explicitly engaged")
        sizes = {dimensions(match.group(2), path) for match in views}
        if len(sizes) != 1:
            raise SystemExit(f"{path}: pair/body/mate bore or thickness differs: {sorted(sizes)}")
        bore = next(iter(sizes))[1]
        two_d_bores = {
            positional_prefix(match.group(1))[2]
            for match in TWO_D_CALL.finditer(text)
            if len(positional_prefix(match.group(1))) >= 3
        }
        if two_d_bores and two_d_bores != {bore}:
            raise SystemExit(f"{path}: 2D bore differs from 3D views: {sorted(two_d_bores)}")


def main():
    root = Path.cwd()
    findings = []
    for path in sorted((root / "src").rglob("*.scad")):
        findings.extend(check_file(path))
    findings.extend(check_markdown_modules(root))
    if findings:
        print("\n".join(findings))
        return 1
    check_pair_examples(root)
    print("PASS: source documentation contracts and Markdown module boundaries agree")
    print("PASS: 16 normal and 16 alternative pair-example invariants agree")
    return 0


if __name__ == "__main__":
    sys.exit(main())
