"""Check pair-example engagement and shared physical dimensions."""

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
PAIR_CALL = re.compile(r"curve_gear_[a-z0-9_]+_pair\(([^;]+)\);")
VIEW_CALL = re.compile(r"curve_gear_[a-z0-9_]+_(pair|body|mate)\(([^;]+)\);")
TWO_D_CALL = re.compile(r"curve_gear_[a-z0-9_]+(?:_body)?_2d\(([^;]+)\);")


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


def check_normal_dimensions(normal):
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
                views[view] = dimensions(
                    call_arguments(path, f"curve_gear_{family}_{view}"), path
                )
        if len(views) == 3 and len(set(views.values())) != 1:
            raise SystemExit(f"{pair.parent}: normal pair/body/mate dimensions differ: {views}")


def main():
    normal = sorted((ROOT / "examples/functions").glob("*/curve_gear_*_pair.scad"))
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
    check_normal_dimensions(normal)

    alternatives = sorted((ROOT / "examples/functions").glob("*/curve_gear_*_alternative.scad"))
    wrappers = [
        path for path in alternatives
        if not any(marker in path.name for marker in ("_pair_alternative", "_body_alternative", "_mate_alternative"))
    ]
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

    print("PASS: 16 normal and 16 alternative pair-example invariants agree")


if __name__ == "__main__":
    main()
