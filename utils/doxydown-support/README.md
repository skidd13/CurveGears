# Doxydown support snippets

These files are project-owned page fragments used by the documentation build.
The pinned utility under `../doxydown/` remains an independent upstream
dependency and should not contain CurveGears-specific page structure.

- `navigation.md` is the single navigation template used by the root README,
  focused documentation pages, the examples catalogue, and the test catalogue.
  Its path placeholders are rendered by Make for each output location.
- `footer.md` is the single footer template appended to generated pages.

SCAD module comment blocks remain the canonical source for page content. The
example catalogue header lives at `examples/.doxydown_module.md`; the test
catalogue uses one header per logical section under `tests/.doxydown_*.md`.
Doxydown accepts each module header and its source files as positional inputs
and concatenates the resulting module streams in argument order while parsing.
These support templates contain only page-level structure and navigation.
