# Tooth construction

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md) · [Fourier](fourier.md)
  - [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Pascal](pascal.md) · [Superformula](superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Tooth Generation`

This layer owns the pinned reference involute equations, local flank polylines,
tangent-aligned top closure, shared tolerances and validation. It is independent
of curve-family placement. The candidate is calculated once per gear and reused.
Validation follows kill-early-kill-cheap order: finite geometry, flank shape and
ordering, top geometry, crossings, then the expensive boundary scan.

### Brief content:

**Functions**:

> [`_cg_involute(r, rho)`](#function-_cg_involuter-rho): Evaluate one point of the local circular involute approximation.

> [`_cg_addendum(modul)`](#function-_cg_addendummodul): Calculate the reference addendum for a module.

> [`_cg_default_clearance(modul)`](#function-_cg_default_clearancemodul): Calculate the default radial root clearance.

> [`_cg_dedendum(modul, clearance)`](#function-_cg_dedendummodul-clearance): Calculate the tooth dedendum from module and optional clearance.

> [`_cg_default_backlash(modul)`](#function-_cg_default_backlashmodul): Calculate the reference backlash for a module.

> [`_cg_tooth_angles(modul, z, pressure_angle, backlash)`](#function-_cg_tooth_anglesmodul-z-pressure_angle-backlash): Calculate the radii and angular limits of a reference tooth.

> [`_cg_tooth_polygon(modul, z, pressure_angle, backlash)`](#function-_cg_tooth_polygonmodul-z-pressure_angle-backlash): Build the local polygon for one reference tooth.

> [`_cg_involute_tooth(modul, tooth_number, pressure_angle, backlash)`](#function-_cg_involute_toothmodul-tooth_number-pressure_angle-backlash): Render the legacy compatibility involute-tooth module.

> [`_cg_eps_len`](#function-_cg_eps_len): Return the shared positional tolerance for tooth checks.

> [`_cg_eps_angle`](#function-_cg_eps_angle): Return the shared angular tolerance for tooth checks.

> [`_cg_eps_intersect`](#function-_cg_eps_intersect): Return the shared segment-intersection tolerance.

> [`_cg_eps_area`](#function-_cg_eps_area): Return the minimum meaningful polygon area.

> [`_cg_signed_area`](#function-_cg_signed_area): Calculate the signed area of a closed 2D polyline.

> [`_cg_point_finite`](#function-_cg_point_finite): Test whether one 2D point contains finite coordinates.

> [`_cg_polyline_finite`](#function-_cg_polyline_finite): Test every point in a polyline for finite coordinates.

> [`_cg_segment_intersection`](#function-_cg_segment_intersection): Test two segments and return their intersection parameters.

> [`_cg_bbox_segments_overlap`](#function-_cg_bbox_segments_overlap): Perform a cheap bounding-box overlap test for two segments.

> [`_cg_polygon_intersections`](#function-_cg_polygon_intersections): Find exact non-neighbouring polygon crossings after broad phase.

> [`_cg_polygon_area`](#function-_cg_polygon_area): Calculate the absolute area of a closed polyline.

> [`_cg_vertical_line_hits`](#function-_cg_vertical_line_hits): Find finite flank intersections at a top x coordinate.

> [`_cg_top_line_crosses_flank`](#function-_cg_top_line_crosses_flank): Detect unintended top/flank crossings.

> [`_cg_first_flank_crossing`](#function-_cg_first_flank_crossing): Detect the first left/right flank crossing before the top.

> [`_cg_has_flank_crossing(left, right)`](#function-_cg_has_flank_crossingleft-right): Determine whether the two local tooth flanks cross.

> [`_cg_flank_failure_code`](#function-_cg_flank_failure_code): Perform cheap flank checks before crossing scans.

> [`_cg_reference_clearance_fraction`](#function-_cg_reference_clearance_fraction): Convert reference clearance and backlash to a pitch fraction.

> [`_cg_reference_tooth_angles`](#function-_cg_reference_tooth_angles): Return centred source flank angles.

> [`_cg_reference_involute_local_point`](#function-_cg_reference_involute_local_point): Evaluate one reference involute point.

> [`_cg_reference_tooth_local_flanks`](#function-_cg_reference_tooth_local_flanks): Build one cached local tooth flank pair.

> [`_cg_candidate_record(valid, code, top_width, tip_normal_error, left, right, left_top, right_top, boundary, left_hits, right_hits)`](#function-_cg_candidate_recordvalid-code-top_width-tip_normal_error-left-right-left_top-right_top-boundary-left_hits-right_hits): Package the validated local-tooth candidate state.

> [`_cg_validate_candidate_boundary(left, right, left_top, right_top, top_width, tip_normal_error, left_hits, right_hits)`](#function-_cg_validate_candidate_boundaryleft-right-left_top-right_top-top_width-tip_normal_error-left_hits-right_hits): Perform the final local tooth polygon self-intersection check.

> [`_cg_validate_candidate_top_geometry(left, right, left_top, right_top, top_width, tip_normal_error, left_hits, right_hits)`](#function-_cg_validate_candidate_top_geometryleft-right-left_top-right_top-top_width-tip_normal_error-left_hits-right_hits): Check top-line crossings before the final boundary scan.

> [`_cg_validate_candidate_top(left, right)`](#function-_cg_validate_candidate_topleft-right): Validate top intersections, width, endpoint order and tangency.

> [`_cg_validate_candidate_flanks(flanks)`](#function-_cg_validate_candidate_flanksflanks): Validate finite and ordered flanks before top and boundary checks.

> [`_cg_reference_tooth_candidate(pitch_radius, modul, tooth_number, ...)`](#function-_cg_reference_tooth_candidatepitch_radius-modul-tooth_number-): Return one cached, validated local candidate tooth.


## Functions

The module `Tooth Generation` defines the following functions.

### Function `_cg_involute(r, rho)`


Evaluate one point of the local circular involute approximation.

**Parameters:**

- `r`: {number > 0} Base radius in mm.
- `rho`: {angle} Involute parameter in degrees.

**Returns:**

- `{array}`: `[radius, angle]` polar point.

Back to [module description](#module-tooth-generation).

### Function `_cg_addendum(modul)`


Calculate the reference addendum for a module.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.

**Returns:**

- `{number}`: Addendum in mm.

Back to [module description](#module-tooth-generation).

### Function `_cg_default_clearance(modul)`


Calculate the default radial root clearance.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.

**Returns:**

- `{number}`: Default clearance in mm.

Back to [module description](#module-tooth-generation).

### Function `_cg_dedendum(modul, clearance)`


Calculate the tooth dedendum from module and optional clearance.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `clearance`: {undef or >= 0} Optional radial root clearance in mm.

**Returns:**

- `{number}`: Dedendum in mm.

Back to [module description](#module-tooth-generation).

### Function `_cg_default_backlash(modul)`


Calculate the reference backlash for a module.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.

**Returns:**

- `{number}`: Default backlash in mm.

Back to [module description](#module-tooth-generation).

### Function `_cg_tooth_angles(modul, z, pressure_angle, backlash)`


Calculate the radii and angular limits of a reference tooth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `z`: {integer >= 3} Tooth count.
- `pressure_angle`: {angle} Involute pressure angle in degrees.
- `backlash`: {undef or >= 0} Optional backlash in mm.

**Returns:**

- `{array}`: Reference radii and angular values used by the tooth builder.

Back to [module description](#module-tooth-generation).

### Function `_cg_tooth_polygon(modul, z, pressure_angle, backlash)`


Build the local polygon for one reference tooth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `z`: {integer >= 3} Tooth count.
- `pressure_angle`: {angle, default 20} Involute pressure angle in degrees.
- `backlash`: {undef or >= 0} Optional backlash in mm.

**Returns:**

- `{array}`: Local tooth polygon points.

Back to [module description](#module-tooth-generation).

### Function `_cg_involute_tooth(modul, tooth_number, pressure_angle, backlash)`


Render the legacy compatibility involute-tooth module.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `pressure_angle`: {angle, default 20} Involute pressure angle in degrees.
- `backlash`: {undef or >= 0} Optional backlash in mm.

**Returns:**

- `{geometry}`: Bounded legacy involute tooth.

Back to [module description](#module-tooth-generation).

### Function `_cg_eps_len`


Return the shared positional tolerance for tooth checks.

**Parameters:**

No parameters

**Returns:**

- `{number}`: Positional tolerance.

Back to [module description](#module-tooth-generation).

### Function `_cg_eps_angle`


Return the shared angular tolerance for tooth checks.

**Parameters:**

No parameters

**Returns:**

- `{number}`: Angular tolerance in degrees.

Back to [module description](#module-tooth-generation).

### Function `_cg_eps_intersect`


Return the shared segment-intersection tolerance.

**Parameters:**

No parameters

**Returns:**

- `{number}`: Segment-intersection tolerance.

Back to [module description](#module-tooth-generation).

### Function `_cg_eps_area`


Return the minimum meaningful polygon area.

**Parameters:**

No parameters

**Returns:**

- `{number}`: Polygon-area tolerance.

Back to [module description](#module-tooth-generation).

### Function `_cg_signed_area`


Calculate the signed area of a closed 2D polyline.

**Parameters:**

- `points`: {array of points} Closed 2D polyline.

**Returns:**

- `{number}`: Signed polygon area.

Back to [module description](#module-tooth-generation).

### Function `_cg_point_finite`


Test whether one 2D point contains finite coordinates.

**Parameters:**

- `p`: {point} Point to test.

**Returns:**

- `{boolean}`: True when both coordinates are finite.

Back to [module description](#module-tooth-generation).

### Function `_cg_polyline_finite`


Test every point in a polyline for finite coordinates.

**Parameters:**

- `points`: {array of points} Polyline to test.

**Returns:**

- `{boolean}`: True when every point is finite.

Back to [module description](#module-tooth-generation).

### Function `_cg_segment_intersection`


Test two segments and return their intersection parameters.

**Parameters:**

- `a`: {point} First segment start.
- `b`: {point} First segment end.
- `c`: {point} Second segment start.
- `d`: {point} Second segment end.

**Returns:**

- `{array}`: `[hit, point, t, u]` intersection result.

Back to [module description](#module-tooth-generation).

### Function `_cg_bbox_segments_overlap`


Perform a cheap bounding-box overlap test for two segments.

**Parameters:**

- `a`: {point} First segment start.
- `b`: {point} First segment end.
- `c`: {point} Second segment start.
- `d`: {point} Second segment end.

**Returns:**

- `{boolean}`: True when the segment bounding boxes overlap.

Back to [module description](#module-tooth-generation).

### Function `_cg_polygon_intersections`


Find exact non-neighbouring polygon crossings after broad phase.

**Parameters:**

- `points`: {array of points} Closed polygon to inspect.

**Returns:**

- `{array}`: Non-neighbouring segment intersection records.

Back to [module description](#module-tooth-generation).

### Function `_cg_polygon_area`


Calculate the absolute area of a closed polyline.

**Parameters:**

- `points`: {array of points} Closed polygon.

**Returns:**

- `{number}`: Absolute polygon area.

Back to [module description](#module-tooth-generation).

### Function `_cg_vertical_line_hits`


Find finite flank intersections at a top x coordinate.

**Parameters:**

- `points`: {array of points} Flank polyline.
- `x`: {number} Top-line x coordinate.

**Returns:**

- `{array}`: Segment indices and intersection points.

Back to [module description](#module-tooth-generation).

### Function `_cg_top_line_crosses_flank`


Detect unintended top/flank crossings.

**Parameters:**

- `top_left`: {point} Left end of the top line.
- `top_right`: {point} Right end of the top line.
- `flank`: {array of points} Flank polyline.

**Returns:**

- `{boolean}`: True when the top line crosses the flank internally.

Back to [module description](#module-tooth-generation).

### Function `_cg_first_flank_crossing`


Detect the first left/right flank crossing before the top.

**Parameters:**

- `left`: {array of points} Left flank polyline.
- `right`: {array of points} Right flank polyline.

**Returns:**

- `{array}`: Crossing status, segment indices and point.

Back to [module description](#module-tooth-generation).

### Function `_cg_has_flank_crossing(left, right)`


Determine whether the two local tooth flanks cross.

**Parameters:**

- `left`: {array} Left flank points.
- `right`: {array} Right flank points.

**Returns:**

- `{boolean}`: True when a non-origin crossing is found.

Back to [module description](#module-tooth-generation).

### Function `_cg_flank_failure_code`


Perform cheap flank checks before crossing scans.

**Parameters:**

- `left`: {array of points} Left flank polyline.
- `right`: {array of points} Right flank polyline.
- `top_left`: {point} Left top corner.
- `top_right`: {point} Right top corner.

**Returns:**

- `{string}`: Validation failure code or `PASS`.

Back to [module description](#module-tooth-generation).

### Function `_cg_reference_clearance_fraction`


Convert reference clearance and backlash to a pitch fraction.

**Parameters:**

- `modul`: {number > 0} Tooth module.
- `tooth_number`: {integer >= 3} Number of teeth.
- `clearance`: {number >= 0} Radial root clearance.
- `backlash`: {number >= 0} Tangential tooth-thickness reduction.

**Returns:**

- `{number}`: Normalised pitch fraction.

Back to [module description](#module-tooth-generation).

### Function `_cg_reference_tooth_angles`


Return centred source flank angles.

**Parameters:**

- `modul`: {number > 0} Tooth module.
- `tooth_number`: {integer >= 3} Number of teeth.
- `pressure_angle`: {number} Involute pressure angle in degrees.
- `backlash`: {number >= 0} Tangential tooth-thickness reduction.

**Returns:**

- `{array}`: Left and right flank angles.

Back to [module description](#module-tooth-generation).

### Function `_cg_reference_involute_local_point`


Evaluate one reference involute point.

**Parameters:**

- `base_radius`: {number > 0} Involute base radius.
- `t`: {number >= 0} Involute parameter.

**Returns:**

- `{point}`: Local involute point.

Back to [module description](#module-tooth-generation).

### Function `_cg_reference_tooth_local_flanks`


Build one cached local tooth flank pair.

**Parameters:**

- `modul`: {number > 0} Tooth module.
- `tooth_number`: {integer >= 3} Number of teeth.
- `pressure_angle`: {number} Involute pressure angle in degrees.
- `clearance`: {number >= 0} Radial root clearance.
- `backlash`: {number >= 0} Tangential tooth-thickness reduction.

**Returns:**

- `{array}`: Local left and right flank polylines.

Back to [module description](#module-tooth-generation).

### Function `_cg_candidate_record(valid, code, top_width, tip_normal_error, left, right, left_top, right_top, boundary, left_hits, right_hits)`


Package the validated local-tooth candidate state.

**Parameters:**

- `valid`: {boolean} Candidate validity flag.
- `code`: {string} Validation status code.
- `top_width`: {number} Candidate top width in mm.
- `tip_normal_error`: {number} Tip tangency error in mm.
- `left`: {array} Left flank points.
- `right`: {array} Right flank points.
- `left_top`: {array} Left top point.
- `right_top`: {array} Right top point.
- `boundary`: {array} Candidate boundary points.
- `left_hits`: {array} Left top-intersection records.
- `right_hits`: {array} Right top-intersection records.

**Returns:**

- `{array}`: Candidate record.

Back to [module description](#module-tooth-generation).

### Function `_cg_validate_candidate_boundary(left, right, left_top, right_top, top_width, tip_normal_error, left_hits, right_hits)`


Perform the final local tooth polygon self-intersection check.

**Parameters:**

- `left`: {array} Left flank points.
- `right`: {array} Right flank points.
- `left_top`: {array} Left top point.
- `right_top`: {array} Right top point.
- `top_width`: {number} Candidate top width in mm.
- `tip_normal_error`: {number} Tip tangency error in mm.
- `left_hits`: {array} Left top-intersection records.
- `right_hits`: {array} Right top-intersection records.

**Returns:**

- `{array}`: Validated or failed candidate record.

Back to [module description](#module-tooth-generation).

### Function `_cg_validate_candidate_top_geometry(left, right, left_top, right_top, top_width, tip_normal_error, left_hits, right_hits)`


Check top-line crossings before the final boundary scan.

**Parameters:**

- `left`: {array} Left flank points.
- `right`: {array} Right flank points.
- `left_top`: {array} Left top point.
- `right_top`: {array} Right top point.
- `top_width`: {number} Candidate top width in mm.
- `tip_normal_error`: {number} Tip tangency error in mm.
- `left_hits`: {array} Left top-intersection records.
- `right_hits`: {array} Right top-intersection records.

**Returns:**

- `{array}`: Validated or failed candidate record.

Back to [module description](#module-tooth-generation).

### Function `_cg_validate_candidate_top(left, right)`


Validate top intersections, width, endpoint order and tangency.

**Parameters:**

- `left`: {array} Left flank points.
- `right`: {array} Right flank points.

**Returns:**

- `{array}`: Validated or failed candidate record.

Back to [module description](#module-tooth-generation).

### Function `_cg_validate_candidate_flanks(flanks)`


Validate finite and ordered flanks before top and boundary checks.

**Parameters:**

- `flanks`: {array} Pair of left and right flank point lists.

**Returns:**

- `{array}`: Validated or failed candidate record.

Back to [module description](#module-tooth-generation).

### Function `_cg_reference_tooth_candidate(pitch_radius, modul, tooth_number, ...)`


![Validated tooth candidate preview](../images/tooth/construction.png)

Return one cached, validated local candidate tooth.

**Parameters:**

- `pitch_radius`: {number > 0} Pitch radius used to scale the reference tooth.
- `modul`: {number > 0} Tooth module.
- `tooth_number`: {integer >= 3} Number of teeth.
- `pressure_angle`: {number} Involute pressure angle in degrees.
- `clearance`: {number >= 0} Radial root clearance.
- `backlash`: {number >= 0} Tangential tooth-thickness reduction.

**Returns:**

- `{array}`: Validated local tooth candidate and status information.

Back to [module description](#module-tooth-generation).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
