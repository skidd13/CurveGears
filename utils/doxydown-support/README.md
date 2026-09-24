# Doxydown support snippets

These files are project-owned page fragments used by the documentation build.
The pinned utility under `../doxydown/` remains an independent upstream
dependency and should not contain CurveGears-specific page structure.

- `navigation.md` is the single navigation template used by the root README,
  focused documentation pages, the examples catalogue, and the test catalogue.
  Its path placeholders are rendered by Make for each output location.
- `footer.md` is the single footer template appended to generated pages.

SCAD module comment blocks remain the canonical source for page content. The
catalogue headers live beside their source streams as `examples/.doxydown_module.md`
and `tests/.doxydown_module.md`. Doxydown accepts the module header and source files as positional
inputs and concatenates them in argument order while parsing. These support
templates contain only page-level structure and navigation.
