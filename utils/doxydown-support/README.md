# Doxydown support snippets

These files are project-owned page fragments used by the documentation build.
The pinned utility under `../doxydown/` remains an independent upstream
dependency and should not contain CurveGears-specific page structure.

- `navigation.md` is the single navigation template used by the root README,
  focused documentation pages, the examples catalogue, and the test catalogue.
  Its path placeholders are rendered by Make for each output location.
- `footer.md` is the single footer template appended to generated pages.

SCAD module comment blocks remain the canonical source for page content. These
templates contain only page-level structure and navigation. Doxydown adds
source links and can infer a catalogue entry from an ordinary first-line
comment when a fixture has no Doxygen block.
