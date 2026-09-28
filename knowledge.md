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

## Performance notes

- Build `_cg_canonical_body_polyline` directly from the sampled pitch points:
  its former arc lookups targeted those exact sample vertices. Compute contour
  winding once per body, then derive every normal from that winding. This
  avoids a full signed-area scan and arc lookup for every body point while
  preserving the existing output geometry.
- On 2026-09-28, the Superformula Make full-pipeline render measured 43.892 s
  and 43.195 s before this change, then 42.501 s and 42.630 s after it. The
  medians were 43.544 s and 42.566 s (about 2.2% faster). The generated STL
  SHA-256 remained `33663e67e832d059789ac132cbce9443ea7bb4dfc765116639247b5b14dfb5c3`.
  Treat this as a modest result for that fixture, not a guarantee for every
  family or sample density.
- Pair builders can pass a pre-sampled unit curve to their existing common
  scaling helpers. Keep scaling in the shared math layer; the Superformula
  pair render showed no measurable end-to-end speedup from sample reuse alone.
