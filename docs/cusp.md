# Cusp

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Cusp`


The deltoid pitch curve has three equally spaced cusps, so the tooth count
must be divisible by three. A standard validated tooth profile is placed at
each cusp after being shifted inward to fit the local curve width. The mate
is generated from the complete placed driver outline and the closed motion
table. The public gear, body, mate, centre-distance, rotation, and pair APIs
are documented together below.

### Brief content:

**Functions**:

> [`curve_gear_cusp(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cuspmodul-tooth_number-width-bore-): Build the three-cusp deltoid gear with regular radial teeth at its cusps.

> [`curve_gear_cusp_2d(modul, tooth_number, bore, ...)`](#function-curve_gear_cusp_2dmodul-tooth_number-bore-): Emit the complete cusp gear profile as 2D geometry.

> [`curve_gear_cusp_body(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cusp_bodymodul-tooth_number-width-bore-): Build the three-cusp deltoid body with its integrated cusp-tip teeth.

> [`curve_gear_cusp_body_2d(modul, tooth_number, bore, ...)`](#function-curve_gear_cusp_body_2dmodul-tooth_number-bore-): Emit the integrated-tip cusp body as 2D geometry with an optional inward offset.

> [`curve_gear_cusp_centre_distance(modul, tooth_number, samples=720)`](#function-curve_gear_cusp_centre_distancemodul-tooth_number-samples720): Return the solved pitch-curve centre distance for a cusp pair.

> [`curve_gear_cusp_mate(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cusp_matemodul-tooth_number-width-bore-): Build the standalone swept-envelope mate for a cusp gear.

> [`curve_gear_cusp_mate_rotation(modul, tooth_number, samples=720, phase=0)`](#function-curve_gear_cusp_mate_rotationmodul-tooth_number-samples720-phase0): Return the integrated mate angle at one driver phase.

> [`curve_gear_cusp_pair(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cusp_pairmodul-tooth_number-width-bore-): Build a meshed or separated deltoid cusp gear pair with a swept-envelope mate.

> [`_cg_cusp_anchor_placement(points, arc, perimeter, body, modul, tooth_number, index, candidate, phase=-90)`](#function-_cg_cusp_anchor_placementpoints-arc-perimeter-body-modul-tooth_number-index-candidate-phase-90): Place a standard tooth in the analytic cusp-axis frame and trim its shoulder interval.

> [`_cg_cusp_body_branch_point(a, t, dedendum)`](#function-_cg_cusp_body_branch_pointa-t-dedendum): Find a radial-root point on one deltoid branch.

> [`_cg_cusp_body_outline(state, tooth_number)`](#function-_cg_cusp_body_outlinestate-tooth_number): Build the cusp-family body outline with its integrated tip teeth.

> [`_cg_cusp_build(modul, tooth_number, width, bore, pressure_angle=20, backlash=undef, clearance=undef, samples=720, orientation=0, body_only=false)`](#function-_cg_cusp_buildmodul-tooth_number-width-bore-pressure_angle20-backlashundef-clearanceundef-samples720-orientation0-body_onlyfalse): Construct the validated cusp body or complete gear.

> [`_cg_cusp_cross2(a, b)`](#function-_cg_cusp_cross2a-b): Calculate the scalar 2D cross product of two vectors.

> [`_cg_cusp_envelope_driver_outline(state)`](#function-_cg_cusp_envelope_driver_outlinestate): Extract the complete placed driver outline from its validated state.

> [`_cg_cusp_envelope_mate_from_geometry(geometry, modul, width, bore, sweep_steps=360, max_pose_step=0.5, sweep_clearance=0.08, phase=0)`](#function-_cg_cusp_envelope_mate_from_geometrygeometry-modul-width-bore-sweep_steps360-max_pose_step05-sweep_clearance008-phase0): Build the cusp mate by sweeping the complete validated driver outline.

> [`_cg_cusp_envelope_mate_outer_radius(geometry, modul)`](#function-_cg_cusp_envelope_mate_outer_radiusgeometry-modul): Calculate the swept-envelope mate's outer blank radius.

> [`_cg_cusp_indices(tooth_number)`](#function-_cg_cusp_indicestooth_number): Return the three tooth indices aligned with the deltoid cusps.

> [`_cg_cusp_pair_build(modul, tooth_number, width, bore, pressure_angle=20, samples=720, phase=0, together_built=true, backlash=undef, clearance=undef, driver_color="SteelBlue", mate_color="Gold", sweep_steps=360, max_pose_step=0.5, sweep_clearance=0.08)`](#function-_cg_cusp_pair_buildmodul-tooth_number-width-bore-pressure_angle20-samples720-phase0-together_builttrue-backlashundef-clearanceundef-driver_colorsteelblue-mate_colorgold-sweep_steps360-max_pose_step05-sweep_clearance008): Construct the cusp driver and swept-envelope mate as a pair.

> [`_cg_cusp_pair_motion_geometry(modul, tooth_number, pressure_angle, backlash, clearance, samples)`](#function-_cg_cusp_pair_motion_geometrymodul-tooth_number-pressure_angle-backlash-clearance-samples): Build the validated cusp driver, radial motion data, solved distance, and motion table from the unmodified deltoid pitch curve.

> [`_cg_cusp_parameter_for_body_y(a, target, dedendum, lo=0, hi=60, i=0)`](#function-_cg_cusp_parameter_for_body_ya-target-dedendum-lo0-hi60-i0): Solve for the deltoid parameter at a requested body-branch height.

> [`_cg_cusp_points(a, samples=720)`](#function-_cg_cusp_pointsa-samples720): Sample one closed three-cusp deltoid pitch curve.

> [`_cg_cusp_prepared_state(points, modul, tooth_number, pressure_angle, backlash, clearance, tip_candidate, phase=-90)`](#function-_cg_cusp_prepared_statepoints-modul-tooth_number-pressure_angle-backlash-clearance-tip_candidate-phase-90): Assemble ordinary and cusp-anchor teeth into one validated state.

> [`_cg_cusp_radius_on_outline(outline, angle)`](#function-_cg_cusp_radius_on_outlineoutline-angle): Find the furthest outline intersection along a radial direction.

> [`_cg_cusp_ray_segment_radius(a, b, angle)`](#function-_cg_cusp_ray_segment_radiusa-b-angle): Find a non-negative ray intersection radius on one outline segment.

> [`_cg_cusp_scale(modul, tooth_number)`](#function-_cg_cusp_scalemodul-tooth_number): Scale the deltoid to the requested module and tooth count.

> [`_cg_cusp_state(modul, tooth_number, pressure_angle=20, backlash=undef, clearance=undef, samples=720)`](#function-_cg_cusp_statemodul-tooth_number-pressure_angle20-backlashundef-clearanceundef-samples720): Construct the complete validated state for a cusp gear.

> [`_cg_cusp_threefold_radii(outline, samples, midpoint, pitch_offset)`](#function-_cg_cusp_threefold_radiioutline-samples-midpoint-pitch_offset): Sample outline radii for all three repeated deltoid sectors.

> [`_cg_cusp_tip_candidate(modul, tooth_number, pressure_angle, backlash, clearance)`](#function-_cg_cusp_tip_candidatemodul-tooth_number-pressure_angle-backlash-clearance): Prepare the standard tooth profile and cusp-anchor dimensions.


## Functions

The module `Cusp` defines the following functions.

### Function `curve_gear_cusp(modul, tooth_number, width, bore, ...)`

| Cusp gear preview | ⠀ |
| --- | --- |
| [![Cusp gear preview](../images/functions/cusp/curve_gear_cusp.png)](../images/functions/cusp/curve_gear_cusp.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


The common candidate validator accepts the full regular radial-root profile. Each cusp tooth is translated inward until its root width meets the local cusp-branch width; the cusp interval is then cropped and replaced by that unchanged tooth profile.
The mate is derived from the full placed driver outline and closed motion table.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Tooth count; one radial tooth is centred on each cusp.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 720, divisible by 3, default 720} Deltoid pitch-curve sampling density for validated cusp teeth.
- `orientation`: {angle, default 0} Whole-gear display rotation in degrees.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_2d(modul, tooth_number, bore, ...)`

| Cusp 2D gear outline | ⠀ |
| --- | --- |
| [![Cusp 2D gear outline](../images/functions/cusp/curve_gear_cusp_2d.png)](../images/functions/cusp/curve_gear_cusp_2d.png) | [![⠀](../utils/doxydown-support/table-spacer-512.png)](../utils/doxydown-support/table-spacer-512.png) |


Emit the complete cusp gear profile as 2D geometry.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Tooth count.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {angle, default 20} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 720, divisible by 3} Deltoid curve sampling density.
- `orientation`: {angle, default 0} Whole-gear rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_cusp_2d(0.8, 36, 4.8);
~~~

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_body(modul, tooth_number, width, bore, ...)`

| Cusp gear body preview | ⠀ |
| --- | --- |
| [![Cusp gear body preview](../images/functions/cusp/curve_gear_cusp_body.png)](../images/functions/cusp/curve_gear_cusp_body.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build the three-cusp deltoid body with its integrated cusp-tip teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Tooth count scale.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch-curve sampling density for validated cusp geometry.
- `orientation`: {angle, default 0} Whole-body display rotation.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_body_2d(modul, tooth_number, bore, ...)`

| Cusp 2D body outline | ⠀ |
| --- | --- |
| [![Cusp 2D body outline](../images/functions/cusp/curve_gear_cusp_body_2d.png)](../images/functions/cusp/curve_gear_cusp_body_2d.png) | [![⠀](../utils/doxydown-support/table-spacer-512.png)](../utils/doxydown-support/table-spacer-512.png) |


Emit the integrated-tip cusp body as 2D geometry with an optional inward offset.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Tooth count.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `samples`: {integer >= 720, divisible by 3} Deltoid curve sampling density.
- `orientation`: {angle, default 0} Whole-body rotation in degrees.
- `body_offset`: {number, default 0} Signed offset in mm; negative shrinks the outer contour and preserves the bore.

**Returns:**

No return

### Example:

~~~c
curve_gear_cusp_body_2d(0.8, 36, 4.8, body_offset=-2);
~~~

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_centre_distance(modul, tooth_number, samples=720)`


Return the solved pitch-curve centre distance for a cusp pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `samples`: {integer >= 120, divisible by 3, default 720} Motion sampling density.

**Returns:**

- `{number}`: Fixed centre distance in mm.

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_mate(modul, tooth_number, width, bore, ...)`

| Cusp gear mate preview | ⠀ |
| --- | --- |
| [![Cusp gear mate preview](../images/functions/cusp/curve_gear_cusp_mate.png)](../images/functions/cusp/curve_gear_cusp_mate.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build the standalone swept-envelope mate for a cusp gear.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Tooth pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 720, divisible by 3, default 720} Motion and pitch-curve sampling density for the validated cusp outline.
- `sweep_steps`: {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
- `max_pose_step`: {number > 0, default 0.5} Maximum angular step of either member in degrees.
- `sweep_clearance`: {number > 0, default 0.08} Envelope cutter clearance as a module fraction.
- `phase`: {angle, default 0} Driver phase used to orient the displayed mate.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_mate_rotation(modul, tooth_number, samples=720, phase=0)`


Return the integrated mate angle at one driver phase.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `samples`: {integer >= 120, divisible by 3, default 720} Motion sampling density.
- `phase`: {angle, default 0} Driver angle in degrees.

**Returns:**

- `{angle}`: Mate display rotation in degrees.

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_pair(modul, tooth_number, width, bore, ...)`

| Cusp pair preview | ⠀ |
| --- | --- |
| [![Cusp pair preview](../images/functions/cusp/curve_gear_cusp_pair.png)](../images/functions/cusp/curve_gear_cusp_pair.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build a meshed or separated deltoid cusp gear pair with a swept-envelope mate.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `width`: {number > 0} Gear extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Tooth pressure angle.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch and motion sampling density for the validated swept mate.
- `phase`: {angle, default 0} Driver motion phase.
- `together_built`: {boolean, default true} Place gears at the solved pitch distance when true.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate colour.
- `sweep_steps`: {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
- `max_pose_step`: {number > 0, default 0.5} Maximum angular step of either member in degrees.
- `sweep_clearance`: {number > 0, default 0.08} Envelope cutter clearance as a module fraction.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `_cg_cusp_anchor_placement(points, arc, perimeter, body, modul, tooth_number, index, candidate, phase=-90)`


Place a standard tooth in the analytic cusp-axis frame and trim its shoulder interval.

**Parameters:**

- `points`: {array of points} Sampled deltoid pitch curve.
- `arc`: {array} Pitch-curve arc-length table.
- `perimeter`: {number > 0} Pitch-curve perimeter in millimetres.
- `body`: {array of points} Radial-root body polyline.
- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `index`: {integer >= 0} Tooth index at this cusp.
- `candidate`: {array} Prepared standard tooth candidate with cusp data.
- `phase`: {angle, default -90} Tooth-placement phase in degrees.

**Returns:**

- `{array}`: Validated cusp-anchor tooth placement record.

Back to [module description](#module-cusp).

### Function `_cg_cusp_body_branch_point(a, t, dedendum)`


Find a radial-root point on one deltoid branch.

**Parameters:**

- `a`: {number > 0} Deltoid scale in millimetres.
- `t`: {angle} Deltoid parameter in degrees.
- `dedendum`: {number >= 0} Tooth-root depth in millimetres.

**Returns:**

- `{array}`: Cartesian body point in millimetres.

Back to [module description](#module-cusp).

### Function `_cg_cusp_body_outline(state, tooth_number)`


Build the cusp-family body outline with its integrated tip teeth.

**Parameters:**

- `state`: {array} Validated cusp gear state.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.

**Returns:**

- `{array of points}`: Closed body and cusp-tip outline.

Back to [module description](#module-cusp).

### Function `_cg_cusp_build(modul, tooth_number, width, bore, pressure_angle=20, backlash=undef, clearance=undef, samples=720, orientation=0, body_only=false)`


Construct the validated cusp body or complete gear.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `width`: {number > 0} Extrusion width in millimetres.
- `bore`: {number >= 0} Centre bore diameter in millimetres.
- `pressure_angle`: {0 < angle < 90, default 20} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch-curve sample count.
- `orientation`: {angle, default 0} Display rotation in degrees.
- `body_only`: {boolean, default false} Emit the integrated body without ordinary teeth.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `_cg_cusp_cross2(a, b)`


Calculate the scalar 2D cross product of two vectors.

**Parameters:**

- `a`: {array of number} First 2D vector.
- `b`: {array of number} Second 2D vector.

**Returns:**

- `{number}`: Scalar cross product.

Back to [module description](#module-cusp).

### Function `_cg_cusp_envelope_driver_outline(state)`


Extract the complete placed driver outline from its validated state.

**Parameters:**

- `state`: {array} Validated cusp tooth-geometry state.

**Returns:**

- `{array of points}`: Closed outline in millimetres.

Back to [module description](#module-cusp).

### Function `_cg_cusp_envelope_mate_from_geometry(geometry, modul, width, bore, sweep_steps=360, max_pose_step=0.5, sweep_clearance=0.08, phase=0)`


Build the cusp mate by sweeping the complete validated driver outline.

**Parameters:**

- `geometry`: {array} Validated cusp pitch and motion state.
- `modul`: {number > 0} Tooth module in millimetres.
- `width`: {number > 0} Extrusion width in millimetres.
- `bore`: {number >= 0} Centre bore diameter in millimetres.
- `sweep_steps`: {integer >= 36, default 360} Base driver-phase intervals.
- `max_pose_step`: {number > 0, default 0.5} Maximum member pose step in degrees.
- `sweep_clearance`: {number > 0, default 0.08} Cutter clearance as a module fraction.
- `phase`: {angle, default 0} Driver phase in degrees.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `_cg_cusp_envelope_mate_outer_radius(geometry, modul)`


Calculate the swept-envelope mate's outer blank radius.

**Parameters:**

- `geometry`: {array} Cusp pitch and motion geometry state.
- `modul`: {number > 0} Tooth module in millimetres.

**Returns:**

- `{number}`: Mate blank radius in millimetres.

Back to [module description](#module-cusp).

### Function `_cg_cusp_indices(tooth_number)`


Return the three tooth indices aligned with the deltoid cusps.

**Parameters:**

- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.

**Returns:**

- `{array of integer}`: Cusp-aligned tooth indices.

Back to [module description](#module-cusp).

### Function `_cg_cusp_pair_build(modul, tooth_number, width, bore, pressure_angle=20, samples=720, phase=0, together_built=true, backlash=undef, clearance=undef, driver_color="SteelBlue", mate_color="Gold", sweep_steps=360, max_pose_step=0.5, sweep_clearance=0.08)`


Construct the cusp driver and swept-envelope mate as a pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `width`: {number > 0} Extrusion width in millimetres.
- `bore`: {number >= 0} Centre bore diameter in millimetres.
- `pressure_angle`: {0 < angle < 90, default 20} Standard-flank pressure angle.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch and motion sample count.
- `phase`: {angle, default 0} Driver motion phase in degrees.
- `together_built`: {boolean, default true} Mesh the pair when true.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver display colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate display colour.
- `sweep_steps`: {integer >= 36, default 360} Base driver-phase intervals.
- `max_pose_step`: {number > 0, default 0.5} Maximum member pose step in degrees.
- `sweep_clearance`: {number > 0, default 0.08} Cutter clearance as a module fraction.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `_cg_cusp_pair_motion_geometry(modul, tooth_number, pressure_angle, backlash, clearance, samples)`


Build the validated cusp driver, radial motion data, solved distance, and motion table from the unmodified deltoid pitch curve.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `pressure_angle`: {0 < angle < 90} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 120, divisible by 3} Motion sampling density.

**Returns:**

- `{array}`: Driver state, radii, solved distance, and integrated motion.

Back to [module description](#module-cusp).

### Function `_cg_cusp_parameter_for_body_y(a, target, dedendum, lo=0, hi=60, i=0)`


Solve for the deltoid parameter at a requested body-branch height.

**Parameters:**

- `a`: {number > 0} Deltoid scale in millimetres.
- `target`: {number} Target Cartesian y coordinate in millimetres.
- `dedendum`: {number >= 0} Tooth-root depth in millimetres.
- `lo`: {angle, default 0} Lower parameter bound in degrees.
- `hi`: {angle, default 60} Upper parameter bound in degrees.
- `i`: {integer >= 0, default 0} Recursion iteration.

**Returns:**

- `{angle}`: Solved deltoid parameter in degrees.

Back to [module description](#module-cusp).

### Function `_cg_cusp_points(a, samples=720)`


Sample one closed three-cusp deltoid pitch curve.

**Parameters:**

- `a`: {number > 0} Deltoid scale in millimetres.
- `samples`: {integer >= 3, divisible by 3, default 720} Sample count.

**Returns:**

- `{array of points}`: Deltoid pitch curve in millimetres.

Back to [module description](#module-cusp).

### Function `_cg_cusp_prepared_state(points, modul, tooth_number, pressure_angle, backlash, clearance, tip_candidate, phase=-90)`


Assemble ordinary and cusp-anchor teeth into one validated state.

**Parameters:**

- `points`: {array of points} Sampled deltoid pitch curve.
- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `pressure_angle`: {0 < angle < 90} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `tip_candidate`: {array} Prepared standard tooth candidate with cusp data.
- `phase`: {angle, default -90} Tooth-placement phase in degrees.

**Returns:**

- `{array}`: Validated complete cusp-gear geometry state.

Back to [module description](#module-cusp).

### Function `_cg_cusp_radius_on_outline(outline, angle)`


Find the furthest outline intersection along a radial direction.

**Parameters:**

- `outline`: {array of points} Closed gear outline.
- `angle`: {angle} Ray direction in degrees.

**Returns:**

- `{number}`: Furthest intersection radius in millimetres.

Back to [module description](#module-cusp).

### Function `_cg_cusp_ray_segment_radius(a, b, angle)`


Find a non-negative ray intersection radius on one outline segment.

**Parameters:**

- `a`: {array of number} First segment endpoint.
- `b`: {array of number} Second segment endpoint.
- `angle`: {angle} Ray direction in degrees.

**Returns:**

- `{number}`: Intersection radius, or zero when there is no hit.

Back to [module description](#module-cusp).

### Function `_cg_cusp_scale(modul, tooth_number)`


Scale the deltoid to the requested module and tooth count.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.

**Returns:**

- `{number}`: Deltoid scale in millimetres.

Back to [module description](#module-cusp).

### Function `_cg_cusp_state(modul, tooth_number, pressure_angle=20, backlash=undef, clearance=undef, samples=720)`


Construct the complete validated state for a cusp gear.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `pressure_angle`: {0 < angle < 90, default 20} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch-curve samples.

**Returns:**

- `{array}`: Validated cusp gear state.

Back to [module description](#module-cusp).

### Function `_cg_cusp_threefold_radii(outline, samples, midpoint, pitch_offset)`


Sample outline radii for all three repeated deltoid sectors.

**Parameters:**

- `outline`: {array of points} Pitch curve or closed driver outline.
- `samples`: {integer >= 3, divisible by 3} Total angular sample count.
- `midpoint`: {boolean} Sample at interval midpoints when true.
- `pitch_offset`: {number} Radial offset in millimetres.

**Returns:**

- `{array of number}`: Threefold radius samples.

Back to [module description](#module-cusp).

### Function `_cg_cusp_tip_candidate(modul, tooth_number, pressure_angle, backlash, clearance)`


Prepare the standard tooth profile and cusp-anchor dimensions.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3, divisible by 3} Number of teeth.
- `pressure_angle`: {0 < angle < 90} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.

**Returns:**

- `{array}`: Standard tooth candidate extended with cusp dimensions.

Back to [module description](#module-cusp).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
