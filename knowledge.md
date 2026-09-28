# CurveGears documentation rules

Keep these rules when editing family documentation:

- Source comments are canonical. Put each Doxydown comment block directly
  before the function or module it describes; keep its summary, parameters,
  and return information attached to that declaration.
- Include every family-private `_cg_*` function and module in that family’s
  generated page. Use an `@function` block for OpenSCAD modules as well, and
  list every declared parameter.
- Each family page has one `@module` overview in its `base.scad`. Do not add
  separate `@module` blocks to that family’s gear, mate, or pair files. Add
  extra implementation files to the family’s Doxydown inputs when their
  private helpers need to appear.
- Keep the README menu generated from `utils/doxydown-support/navigation.md`
  with `make readme`; edit the shared menu once rather than copying link lists.
  Omit the menu's README self-link there, and never put machine-specific
  absolute paths in README or generated documentation.
- Keep Python use limited to cases that clearly need it. Do not add a Python
  helper for a small documentation task when the existing Makefile, shell
  tools, or Doxydown workflow can handle it.
- After source-comment or README edits, run `make docs-pages`, `make readme`,
  and `make check-docs`, then inspect `git diff --check` and generated diffs.

The family order is Bézier, Cassini, Circle, Cusp, Ellipse, Epitrochoid,
Fourier, Hypotrochoid, Lobed, Logarithmic spiral, Pascal, and Superformula.
