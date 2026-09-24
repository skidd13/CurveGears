# Lobed

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md) · [Fourier](fourier.md)
  - [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Pascal](pascal.md) · [Superformula](superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Lobed`


The pitch radius is `r(theta)=s(1+d cos(k theta))`; `k` controls the lobe
count and `d` the radial modulation. Deep modulation can reduce tooth
accessibility. The public gear, mate and pair APIs consume these primitives.
Reference: https://mathworld.wolfram.com/FourierSeries.html.

### Brief content:

**Functions**:

> [`_cg_lobed_unit_radius(lobes, lobe_depth, theta)`](#function-_cg_lobed_unit_radiuslobes-lobe_depth-theta): Evaluate the unit radial modulation of a lobed pitch curve.

> [`_cg_lobed_point(scale, lobes, lobe_depth, theta)`](#function-_cg_lobed_pointscale-lobes-lobe_depth-theta): Evaluate one Cartesian point on a scaled lobed pitch curve.

> [`_cg_lobed_unit_points(lobes, lobe_depth, n)`](#function-_cg_lobed_unit_pointslobes-lobe_depth-n): Sample one complete unit lobed pitch curve.

> [`_cg_lobed_scale(modul, tooth_number, lobes, lobe_depth, n)`](#function-_cg_lobed_scalemodul-tooth_number-lobes-lobe_depth-n): Scale a unit lobed curve to the requested tooth pitch.

> [`_cg_lobed_radius(scale, lobes, lobe_depth, theta)`](#function-_cg_lobed_radiusscale-lobes-lobe_depth-theta): Evaluate a scaled lobed pitch-curve radius.

> [`curve_gear_lobed(modul, tooth_number, width, bore, ...)`](#function-curve_gear_lobedmodul-tooth_number-width-bore-): Build a lobed non-circular gear.

> [`_cg_lobed_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)`](#function-_cg_lobed_buildmodultooth_numberwidthborelobes4lobe_depth013pressure_angle20tooth_phase0backlashundefclearanceundefsamples720orientation0body_onlyfalse): Internal lobed construction dispatcher.

> [`curve_gear_lobed_body(modul, tooth_number, width, bore, ...)`](#function-curve_gear_lobed_bodymodul-tooth_number-width-bore-): Build the lobed body solid without teeth.

> [`_cg_lobed_motion_radii`](#function-_cg_lobed_motion_radii): Evaluate lobed radii at integration midpoints.

> [`_cg_lobed_driver_radii`](#function-_cg_lobed_driver_radii): Evaluate lobed radii at direct mate-construction angles.

> [`_cg_lobed_centre_distance`](#function-_cg_lobed_centre_distance): Solve the lobed conjugate centre distance.

> [`_cg_lobed_motion_table`](#function-_cg_lobed_motion_table): Build the shared lobed phase-motion table.

> [`_cg_lobed_mate_points_from_driver`](#function-_cg_lobed_mate_points_from_driver): Build lobed mate pitch points by advancing driver angle directly.

> [`_cg_lobed_mate_points`](#function-_cg_lobed_mate_points): Build lobed mate pitch points and their shared motion table.

> [`curve_gear_lobed_mate(modul, tooth_number, width, bore, ...)`](#function-curve_gear_lobed_matemodul-tooth_number-width-bore-): Build the standalone lobed mate boundary at the origin.

> [`curve_gear_lobed_centre_distance(modul, tooth_number, lobes, lobe_depth, ...)`](#function-curve_gear_lobed_centre_distancemodul-tooth_number-lobes-lobe_depth-): Return the mathematical centre distance for a lobed pair.

> [`curve_gear_lobed_mate_rotation(modul, tooth_number, lobes, lobe_depth, ...)`](#function-curve_gear_lobed_mate_rotationmodul-tooth_number-lobes-lobe_depth-): Return the conjugate lobed mate rotation for a driver phase.

> [`curve_gear_lobed_pair(modul, tooth_number, width, bore, ...)`](#function-curve_gear_lobed_pairmodul-tooth_number-width-bore-): Build a meshed or separated lobed pair.

> [`_cg_lobed_pair_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")`](#function-_cg_lobed_pair_buildmodultooth_numberwidthborelobes4lobe_depth013pressure_angle20samples720phase0together_builttruebacklashundefclearanceundeftooth_phase0driver_colorsteelbluemate_colorgold): Internal lobed pair construction dispatcher.


## Functions

The module `Lobed` defines the following functions.

### Function `_cg_lobed_unit_radius(lobes, lobe_depth, theta)`


Evaluate the unit radial modulation of a lobed pitch curve.

**Parameters:**

- `lobes`: {integer >= 1} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1} Radial modulation depth.
- `theta`: {angle} Polar angle in degrees.

**Returns:**

- `{number}`: Unit radius at the requested angle.

Back to [module description](#module-lobed).

### Function `_cg_lobed_point(scale, lobes, lobe_depth, theta)`


Evaluate one Cartesian point on a scaled lobed pitch curve.

**Parameters:**

- `scale`: {number > 0} Mean pitch-radius scale in mm.
- `lobes`: {integer >= 1} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1} Radial modulation depth.
- `theta`: {angle} Polar angle in degrees.

**Returns:**

- `{array}`: Cartesian point `[x, y]` in mm.

Back to [module description](#module-lobed).

### Function `_cg_lobed_unit_points(lobes, lobe_depth, n)`


Sample one complete unit lobed pitch curve.

**Parameters:**

- `lobes`: {integer >= 1} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1} Radial modulation depth.
- `n`: {integer >= 1, default 720} Number of samples.

**Returns:**

- `{array}`: Closed list of sampled Cartesian points.

Back to [module description](#module-lobed).

### Function `_cg_lobed_scale(modul, tooth_number, lobes, lobe_depth, n)`


Scale a unit lobed curve to the requested tooth pitch.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `lobes`: {integer >= 1} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1} Radial modulation depth.
- `n`: {integer >= 1, default 720} Number of samples used for arc length.

**Returns:**

- `{number}`: Mean pitch-radius scale in mm.

Back to [module description](#module-lobed).

### Function `_cg_lobed_radius(scale, lobes, lobe_depth, theta)`


Evaluate a scaled lobed pitch-curve radius.

**Parameters:**

- `scale`: {number > 0} Mean pitch-radius scale in mm.
- `lobes`: {integer >= 1} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1} Radial modulation depth.
- `theta`: {angle} Polar angle in degrees.

**Returns:**

- `{number}`: Radius in mm.

Back to [module description](#module-lobed).

### Function `curve_gear_lobed(modul, tooth_number, width, bore, ...)`


![Lobed gear preview](../images/functions/lobed/curve_gear_lobed.png)

Public single-gear construction for the lobed family.
The gear is centred on X=0,Y=0 with its lower face at Z=0.
[`curve_gear_lobed_body`](#f-curve_gear_lobed_body)

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `lobes`: {integer >= 2, default 4} Number of radial lobes.
- `lobe_depth`: {0 < depth < 0.5, default 0.13} Normalised lobe amplitude.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_lobed(1, 24, 4, 8);
~~~

Back to [module description](#module-lobed).

### Function `_cg_lobed_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)`


Internal lobed construction dispatcher.

**Parameters:**

- `modul`: {number} Tooth module in mm.
- `tooth_number`: {integer} Number of teeth.
- `width`: {number} Extrusion width in mm.
- `bore`: {number} Centre bore diameter in mm.
- `lobes`: {integer, default 4} Internal construction parameter.
- `lobe_depth`: {number, default 0.13} Internal construction parameter.
- `pressure_angle`: {number, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {number, default 0} Tooth placement phase in degrees.
- `backlash`: {number, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {number, default undef} Additional radial root clearance in mm.
- `samples`: {integer, default 720} Pitch-curve or motion-table sampling density.
- `orientation`: {number, default 0} Single-gear display rotation in degrees.
- `body_only`: {boolean, default false} Emit the body without teeth.

**Returns:**

- `{geometry}`: Constructed family geometry.

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_body(modul, tooth_number, width, bore, ...)`


![Lobed body preview](../images/functions/lobed/curve_gear_lobed_body.png)

Build the lobed body solid without teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `lobes`: {integer >= 2, default 4} Number of radial lobes.
- `lobe_depth`: {0 < depth < 0.5, default 0.13} Normalised lobe amplitude.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_lobed_body(1, 24, 4, 8);
~~~

Back to [module description](#module-lobed).

### Function `_cg_lobed_motion_radii`


Evaluate lobed radii at integration midpoints.

**Parameters:**

- `scale`: {number > 0} Base radial scale.
- `lobes`: {integer >= 2} Number of radial lobes.
- `lobe_depth`: {number} Normalised lobe amplitude.
- `n`: {integer >= 1, default 360} Number of midpoint samples.

**Returns:**

- `{array of number}`: Sampled radii in angular order.

Back to [module description](#module-lobed).

### Function `_cg_lobed_driver_radii`


Evaluate lobed radii at direct mate-construction angles.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-lobed).

### Function `_cg_lobed_centre_distance`


Solve the lobed conjugate centre distance.

**Parameters:**

- `scale`: {number > 0} Base radial scale.
- `lobes`: {integer >= 2} Number of radial lobes.
- `lobe_depth`: {number} Normalised lobe amplitude.

**Returns:**

- `{number}`: Conjugate centre distance.

Back to [module description](#module-lobed).

### Function `_cg_lobed_motion_table`


Build the shared lobed phase-motion table.

**Parameters:**

- `scale`: {number > 0} Base radial scale.
- `lobes`: {integer >= 2} Number of radial lobes.
- `lobe_depth`: {number} Normalised lobe amplitude.
- `D`: {number > 0} Driver-to-mate centre distance.
- `n`: {integer >= 1, default 360} Number of midpoint samples.

**Returns:**

- `{array}`: Monotonic driver-to-mate phase-motion table.

Back to [module description](#module-lobed).

### Function `_cg_lobed_mate_points_from_driver`


Build lobed mate pitch points by advancing driver angle directly.

**Parameters:**

- `scale`: {number > 0} Base radial scale.
- `lobes`: {integer >= 2} Number of radial lobes.
- `lobe_depth`: {number} Normalised lobe amplitude.
- `D`: {number > 0} Driver-to-mate centre distance.
- `motion`: {array} Shared driver-to-mate phase-motion table.
- `n`: {integer >= 1, default 360} Number of output points.

**Returns:**

- `{array of points}`: Cartesian mate pitch points.

Back to [module description](#module-lobed).

### Function `_cg_lobed_mate_points`


Build lobed mate pitch points and their shared motion table.

**Parameters:**

- `scale`: {number > 0} Base radial scale.
- `lobes`: {integer >= 2} Number of radial lobes.
- `lobe_depth`: {number} Normalised lobe amplitude.
- `D`: {number > 0} Driver-to-mate centre distance.
- `n`: {integer >= 1, default 360} Number of output points.

**Returns:**

- `{array of points}`: Cartesian mate pitch points.

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_mate(modul, tooth_number, width, bore, ...)`


![Lobed mate preview](../images/functions/lobed/curve_gear_lobed_mate.png)

Build the standalone lobed mate boundary at the origin.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `lobes`: {integer >= 2, default 4} Number of radial lobes.
- `lobe_depth`: {0 < depth < 0.5, default 0.13} Normalised lobe amplitude.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.

**Returns:**

No return

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_centre_distance(modul, tooth_number, lobes, lobe_depth, ...)`


Return the mathematical centre distance for a lobed pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `lobes`: {integer >= 1, default 4} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1, default 0.13} Radial modulation depth.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.

**Returns:**

- `{number}`: Pair centre distance in mm.

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_mate_rotation(modul, tooth_number, lobes, lobe_depth, ...)`


Return the conjugate lobed mate rotation for a driver phase.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `lobes`: {integer >= 1, default 4} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1, default 0.13} Radial modulation depth.
- `samples`: {integer >= 120, default 720} Motion-table sampling density.
- `phase`: {angle, default 0} Driver motion phase in degrees.

**Returns:**

- `{angle}`: Mate rotation in degrees.

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_pair(modul, tooth_number, width, bore, ...)`


![Lobed pair preview](../images/functions/lobed/curve_gear_lobed_pair.png)

Pair geometry uses the single-gear parameters documented in gear.scad.
[`curve_gear_lobed`](#f-curve_gear_lobed)

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `lobes`: {integer >= 2, default 4} Number of lobes.
- `lobe_depth`: {0 < depth < 0.5, default 0.13} Lobe depth as a fraction of the mean radius.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.
- `phase`: {angle, default 0} Pair motion phase in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `together_built`: {boolean, default true} Place the pair meshed when true, separated when false.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver display colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate display colour.

**Returns:**

No return

### Example:

~~~c
curve_gear_lobed_pair(1, 24, 4, 8);
~~~

Back to [module description](#module-lobed).

### Function `_cg_lobed_pair_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")`


Internal lobed pair construction dispatcher.

**Parameters:**

- `modul`: {number} Tooth module in mm.
- `tooth_number`: {integer} Number of teeth.
- `width`: {number} Extrusion width in mm.
- `bore`: {number} Centre bore diameter in mm.
- `lobes`: {integer, default 4} Internal construction parameter.
- `lobe_depth`: {number, default 0.13} Internal construction parameter.
- `pressure_angle`: {number, default 20} Involute pressure angle in degrees.
- `samples`: {integer, default 720} Pitch-curve or motion-table sampling density.
- `phase`: {number, default 0} Driver motion phase in degrees.
- `together_built`: {boolean, default true} Use meshed placement when true, display placement otherwise.
- `backlash`: {number, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {number, default undef} Additional radial root clearance in mm.
- `tooth_phase`: {number, default 0} Tooth placement phase in degrees.
- `driver_color`: {string, default "SteelBlue"} Driver display colour.
- `mate_color`: {string, default "Gold"} Mate display colour.

**Returns:**

- `{geometry}`: Constructed family geometry.

Back to [module description](#module-lobed).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
