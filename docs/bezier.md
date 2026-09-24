# Bézier

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md) · [Fourier](fourier.md)
  - [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Pascal](pascal.md) · [Superformula](superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Bezier`

Control points are supplied in groups of three per segment:
[start, handle, handle, end, handle, handle, end, ...]. The final point
must equal the first point. Join tangents must be collinear and forward;
this prevents a hidden corner from entering the tooth sampler.
The cubic curve is exact between controls; the gear boundary uses a sampled
polyline for OpenSCAD polygon construction. Dense sampling is required for
sharp curvature, and arbitrary Cartesian controls are not promised to be a
single-valued radial pitch curve.

The basic curve is `B(t)=(1-t)^3 P0+3(1-t)^2 t P1+3(1-t)t^2 P2+t^3 P3`,
for `0 <= t <= 1`. Reference:
https://www.cs.sjsu.edu/~bruce/fall_2016_cs_116a_lecture_splines.html.

### Brief content:

**Functions**:

> [`_cg_bezier_segment_count`](#function-_cg_bezier_segment_count): Return the number of cubic segments in a closed control-point list.

> [`_cg_bezier_point`](#function-_cg_bezier_point): Evaluate one cubic Bézier segment.

> [`_cg_bezier_controls_valid`](#function-_cg_bezier_controls_valid): Validate closure, segment grouping and forward tangent continuity.

> [`_cg_bezier_points`](#function-_cg_bezier_points): Sample a closed Bézier pitch curve into the shared tooth engine.

> [`_cg_bezier_build(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)`](#function-_cg_bezier_buildmodultooth_numberwidthborecontrol_points_cg_bezier_default_control_pointspressure_angle20tooth_phase0backlashundefclearanceundefsamples720orientation0body_onlyfalse): Internal bezier construction dispatcher.

> [`curve_gear_bezier(modul, tooth_number, width, bore, ...)`](#function-curve_gear_beziermodul-tooth_number-width-bore-): Build a closed cubic Bézier gear from user-controlled normalised points.

> [`curve_gear_bezier_body(modul, tooth_number, width, bore, ...)`](#function-curve_gear_bezier_bodymodul-tooth_number-width-bore-): Build the closed Bézier body without teeth.

> [`curve_gear_bezier_mate`](#function-curve_gear_bezier_mate): Build a conjugate mate for an admissible radial Bézier pitch curve.

> [`curve_gear_bezier_mate_centre_distance(modul, tooth_number, ...)`](#function-curve_gear_bezier_mate_centre_distancemodul-tooth_number-): Return the conjugate centre distance for an admissible Bézier curve.

> [`curve_gear_bezier_mate_rotation(modul, tooth_number, ...)`](#function-curve_gear_bezier_mate_rotationmodul-tooth_number-): Return the conjugate mate rotation for a driver phase.

> [`curve_gear_bezier_pair(modul, tooth_number, width, bore, ...)`](#function-curve_gear_bezier_pairmodul-tooth_number-width-bore-): Build a meshed or separated pair from an admissible Bézier curve.


## Functions

The module `Bezier` defines the following functions.

### Function `_cg_bezier_segment_count`


Return the number of cubic segments in a closed control-point list.

**Parameters:**

- `control_points`: {array of points} Closed Bézier control-point list.

**Returns:**

- `{integer}`: Number of cubic segments.

Back to [module description](#module-bezier).

### Function `_cg_bezier_point`


Evaluate one cubic Bézier segment.

**Parameters:**

- `p0`: {point} Segment start point.
- `p1`: {point} First control point.
- `p2`: {point} Second control point.
- `p3`: {point} Segment end point.
- `t`: {number, 0 <= t <= 1} Segment interpolation parameter.

**Returns:**

- `{point}`: Evaluated Cartesian point.

Back to [module description](#module-bezier).

### Function `_cg_bezier_controls_valid`


Validate closure, segment grouping and forward tangent continuity.

**Parameters:**

- `control_points`: {array of points} Closed Bézier control-point list.

**Returns:**

- `{boolean}`: True when the control list is structurally valid.

Back to [module description](#module-bezier).

### Function `_cg_bezier_points`


Sample a closed Bézier pitch curve into the shared tooth engine.

**Parameters:**

- `control_points`: {array of points} Valid closed Bézier control-point list.
- `scale`: {number > 0} Radial scale applied to each sampled point.
- `samples`: {integer >= 1} Number of output samples.

**Returns:**

- `{array of points}`: Sampled Cartesian pitch points.

Back to [module description](#module-bezier).

### Function `_cg_bezier_build(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)`


Internal bezier construction dispatcher.

**Parameters:**

- `modul`: {number} Tooth module in mm.
- `tooth_number`: {integer} Number of teeth.
- `width`: {number} Extrusion width in mm.
- `bore`: {number} Centre bore diameter in mm.
- `control_points`: {value, default _cg_bezier_default_control_points} Internal construction parameter.
- `pressure_angle`: {number, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {number, default 0} Tooth placement phase in degrees.
- `backlash`: {number, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {number, default undef} Additional radial root clearance in mm.
- `samples`: {integer, default 720} Pitch-curve or motion-table sampling density.
- `orientation`: {number, default 0} Single-gear display rotation in degrees.
- `body_only`: {boolean, default false} Emit the body without teeth.

**Returns:**

- `{geometry}`: Constructed family geometry.

Back to [module description](#module-bezier).

### Function `curve_gear_bezier(modul, tooth_number, width, bore, ...)`


![Bézier gear preview](../images/functions/bezier/curve_gear_bezier.png)

![Bézier asymmetric alternative](../images/functions/bezier/curve_gear_bezier_alternative.png)

Build a closed cubic Bézier gear from user-controlled normalised points.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `control_points`: {closed array grouped as 3n+1 points} Segment endpoints and handles; final point must equal first.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Curve sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_bezier(1, 24, 4, 8);
~~~

Back to [module description](#module-bezier).

### Function `curve_gear_bezier_body(modul, tooth_number, width, bore, ...)`


![Bézier body preview](../images/functions/bezier/curve_gear_bezier_body.png)

Build the closed Bézier body without teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `control_points`: {closed array grouped as 3n+1 points} Segment endpoints and handles; final point must equal first.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Curve sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

Back to [module description](#module-bezier).

### Function `curve_gear_bezier_mate`


![Bézier mate preview](../images/functions/bezier/curve_gear_bezier_mate.png)

Build a conjugate mate for an admissible radial Bézier pitch curve.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `control_points`: {closed array grouped as 3n+1 points} Bézier controls.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Adapter and pitch sampling density.

**Returns:**

No return

Back to [module description](#module-bezier).

### Function `curve_gear_bezier_mate_centre_distance(modul, tooth_number, ...)`


Return the conjugate centre distance for an admissible Bézier curve.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `control_points`: {closed array grouped as 3n+1 points} Bézier controls.
- `samples`: {integer >= 120, default 720} Adapter and pitch sampling density.

**Returns:**

- `{number}`: Conjugate centre distance in mm.

Back to [module description](#module-bezier).

### Function `curve_gear_bezier_mate_rotation(modul, tooth_number, ...)`


Return the conjugate mate rotation for a driver phase.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `control_points`: {closed array grouped as 3n+1 points} Bézier controls.
- `samples`: {integer >= 120, default 720} Adapter and pitch sampling density.
- `phase`: {angle, default 0} Driver motion phase in degrees.

**Returns:**

- `{angle}`: Conjugate mate rotation in degrees.

Back to [module description](#module-bezier).

### Function `curve_gear_bezier_pair(modul, tooth_number, width, bore, ...)`


![Bézier pair preview](../images/functions/bezier/curve_gear_bezier_pair.png)

![Bézier asymmetric alternative pair](../images/functions/bezier/curve_gear_bezier_pair_alternative.png)

Build a meshed or separated pair from an admissible Bézier curve.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `control_points`: {closed array grouped as 3n+1 points} Bézier controls.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `samples`: {integer >= 120, default 720} Adapter and pitch sampling density.
- `phase`: {angle, default 0} Driver motion phase in degrees.
- `together_built`: {boolean, default true} Build the pair as one assembled object when true.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `driver_color`: {colour, default SteelBlue} Driver gear colour.
- `mate_color`: {colour, default Gold} Mate gear colour.

**Returns:**

No return

Back to [module description](#module-bezier).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
