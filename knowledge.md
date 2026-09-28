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
- `_cg_placement_result` already resolves the frame for a tooth target. Forward
  that same frame into `_cg_accessibility_result` through its optional prepared
  frame argument, while keeping the standalone fallback for direct callers.
  Superformula full-pipeline runs measured 44.146 s and 44.116 s before, then
  43.897 s and 43.905 s after. The STL stayed byte-identical, but the roughly
  0.5% timing difference is within run-to-run variation; do not claim a measured
  full-render gain from this reuse alone.
- `_cg_final_boundary_collisions` now trims each placed boundary once and reuses
  it across nearby pair checks. In the same Superformula full-pipeline render,
  timings were 43.897 s and 43.905 s before this change, then 43.730 s and
  43.460 s after; the STL remained byte-identical. The possible gain is small
  and should be remeasured at larger tooth counts before making a broad claim.
- `_cg_segment_hits_polygon` can reject segments whose bounding boxes cannot
  touch the polygon before point-in-polygon and exact edge tests. Expand the
  polygon bounds by a segment-length-scaled intersection tolerance so the
  broad phase preserves the exact test's endpoint allowance. Superformula
  full-pipeline baseline runs were 43.730 s and 43.460 s (43.595 s median); the
  final source ran in 42.479 s and produced the same STL SHA-256 as above. This
  is a modest single-run result for that fixture, not a general guarantee.
- `_cg_accessibility_result` checks many body segments against the same
  corridor polygon. Prepare its bounds and longest edge once, then pass them
  into `_cg_segment_hits_polygon`; standalone calls still calculate their own
  bounds. Preserve the segment-length-scaled tolerance and exact tests. On
  2026-09-28, the Superformula full-pipeline render took 42.418 s before and
  42.097 s twice after; the STL SHA-256 remained identical. This is a small,
  fixture-specific timing difference, not a broad performance guarantee.
- The prepared tooth state trims each placed boundary once and shares those
  boundaries with outline assembly, nearby-pair checks, tooth self-intersection
  checks, and adjacent-contact checks. Keep helper fallbacks for standalone
  calls and the cusp tip-only outline. Superformula full-pipeline timings were
  42.362 s and 42.629 s before, then 41.775 s and 42.052 s after; the STL
  SHA-256 remained identical. The full cusp render and common regression group
  passed. This measured about a 1.4% median improvement for the Superformula
  fixture; remeasure other families before generalising.
- Directly summing the mate-motion closure increments instead of building a
  cumulative table on each centre-distance solver iteration preserved the
  Superformula STL but showed no measurable full-render improvement: baseline
  timings were 42.362 s and 42.629 s, candidate timings 42.743 s and 42.163 s.
  The candidate was discarded.
- Pre-transforming every mate tooth boundary before applying the existing
  pitch-distance filter was slower: the Superformula pair render measured
  45.935 s and 45.970 s at baseline, then 46.230 s with the candidate. Its STL
  was identical; the extra work on distant pairs outweighed reuse, so the
  candidate was discarded.
