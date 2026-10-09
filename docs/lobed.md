# Lobed

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
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

> [`curve_gear_lobed`](#function-curve_gear_lobed): Build a lobed non-circular gear.

> [`curve_gear_lobed_2d`](#function-curve_gear_lobed_2d): Emit the complete lobed gear profile as 2D geometry.

> [`curve_gear_lobed_body`](#function-curve_gear_lobed_body): Build the lobed body solid without teeth.

> [`curve_gear_lobed_body_2d`](#function-curve_gear_lobed_body_2d): Emit the lobed body as 2D geometry with an optional signed outer-contour offset.

> [`curve_gear_lobed_centre_distance`](#function-curve_gear_lobed_centre_distance): Return the mathematical centre distance for a lobed pair.

> [`curve_gear_lobed_mate`](#function-curve_gear_lobed_mate): Build the standalone lobed mate boundary at the origin.

> [`curve_gear_lobed_mate_rotation`](#function-curve_gear_lobed_mate_rotation): Return the conjugate lobed mate rotation for a driver phase.

> [`curve_gear_lobed_pair`](#function-curve_gear_lobed_pair): Build a meshed or separated lobed pair.

> [`_cg_lobed_build`](#function-_cg_lobed_build): Internal lobed construction dispatcher.

> [`_cg_lobed_pair_build`](#function-_cg_lobed_pair_build): Internal lobed pair construction dispatcher.

> [`_cg_lobed_unit_radius`](#function-_cg_lobed_unit_radius): Evaluate the unit radial modulation r=s(1+d cos(kθ)) of a harmonic lobed pitch curve, whose teeth are placed by arc length.


## Functions

The module `Lobed` defines the following functions.

### Function `curve_gear_lobed`

| Lobed gear 1 | Lobed gear 2 |
| --- | --- |
| [![curve_gear_lobed example preview](../images/functions/lobed/curve_gear_lobed.png)](../images/functions/lobed/curve_gear_lobed.png) | [![Lobed gear alternative](../images/functions/lobed/curve_gear_lobed_alternative.png)](../images/functions/lobed/curve_gear_lobed_alternative.png) |


Public single-gear construction for the lobed family.
Two deep lobes replace the canonical shallow four-lobed square form. Lobe count 2 and depth 0.28 show the transition to an elongated, waisted pitch curve.
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

### Function `curve_gear_lobed_2d`

| Lobed 2D gear 1 | Lobed 2D gear 2 |
| --- | --- |
| [![lobed 2D gear outline](../images/functions/lobed/curve_gear_lobed_2d.png)](../images/functions/lobed/curve_gear_lobed_2d.png) | [![Lobed 2D gear alternative](../images/functions/lobed/curve_gear_lobed_alternative_2d.png)](../images/functions/lobed/curve_gear_lobed_alternative_2d.png) |


Emit the complete lobed gear profile as 2D geometry.

**Parameters:**

- `modul`: {value} Tooth module in mm.
- `tooth_number`: {value} Number of teeth.
- `bore`: {value} Centre bore diameter in mm.
- `lobes`: {value} Same family-specific parameter as curve_gear_lobed.
- `lobe_depth`: {value} Same family-specific parameter as curve_gear_lobed.
- `pressure_angle`: {value} Same family-specific parameter as curve_gear_lobed.
- `tooth_phase`: {value} Same family-specific parameter as curve_gear_lobed.
- `backlash`: {value} Same family-specific parameter as curve_gear_lobed.
- `clearance`: {value} Same family-specific parameter as curve_gear_lobed.
- `samples`: {value} Same family-specific parameter as curve_gear_lobed.
- `orientation`: {value} Rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_lobed_2d(0.8, 34, 4.8);
~~~

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_body`

| Lobed body 1 | Lobed body 2 |
| --- | --- |
| [![curve_gear_lobed_body example preview](../images/functions/lobed/curve_gear_lobed_body.png)](../images/functions/lobed/curve_gear_lobed_body.png) | [![Lobed body alternative](../images/functions/lobed/curve_gear_lobed_body_alternative.png)](../images/functions/lobed/curve_gear_lobed_body_alternative.png) |


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

### Function `curve_gear_lobed_body_2d`

| Lobed 2D body 1 | Lobed 2D body 2 |
| --- | --- |
| [![lobed 2D body outline](../images/functions/lobed/curve_gear_lobed_body_2d.png)](../images/functions/lobed/curve_gear_lobed_body_2d.png) | [![Lobed 2D body alternative](../images/functions/lobed/curve_gear_lobed_body_alternative_2d.png)](../images/functions/lobed/curve_gear_lobed_body_alternative_2d.png) |


Emit the lobed body as 2D geometry with an optional signed outer-contour offset.

**Parameters:**

- `modul`: {value} Tooth module in mm.
- `tooth_number`: {value} Number of teeth.
- `bore`: {value} Centre bore diameter in mm.
- `lobes`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `lobe_depth`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `pressure_angle`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `tooth_phase`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `backlash`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `clearance`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `samples`: {value} Same family-specific parameter as curve_gear_lobed_body.
- `orientation`: {value} Rotation in degrees.
- `body_offset`: {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.

**Returns:**

No return

### Example:

~~~c
curve_gear_lobed_body_2d(0.8, 34, 4.8, body_offset=-2);
~~~

Back to [module description](#module-lobed).

### Function `curve_gear_lobed_centre_distance`


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

### Function `curve_gear_lobed_mate`

| Lobed mate 1 | Lobed mate 2 |
| --- | --- |
| [![curve_gear_lobed_mate example preview](../images/functions/lobed/curve_gear_lobed_mate.png)](../images/functions/lobed/curve_gear_lobed_mate.png) | [![Lobed mate alternative](../images/functions/lobed/curve_gear_lobed_mate_alternative.png)](../images/functions/lobed/curve_gear_lobed_mate_alternative.png) |


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

### Function `curve_gear_lobed_mate_rotation`


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

### Function `curve_gear_lobed_pair`

| Lobed pair 1 | Lobed pair 2 |
| --- | --- |
| [![curve_gear_lobed_pair example preview](../images/functions/lobed/curve_gear_lobed_pair.png)](../images/functions/lobed/curve_gear_lobed_pair.png) | [![Lobed pair alternative](../images/functions/lobed/curve_gear_lobed_pair_alternative.png)](../images/functions/lobed/curve_gear_lobed_pair_alternative.png) |


Pair geometry uses the single-gear parameters documented in gear.scad.
[`curve_gear_lobed`](#f-curve_gear_lobed)

**Parameters:**

- `modul`: {number > 0, default .8} Tooth module in mm.
- `tooth_number`: {integer >= 3, default 34} Number of teeth.
- `width`: {number > 0, default 4} Extrusion width in mm.
- `bore`: {number >= 0, default 4.8} Centre bore diameter in mm.
- `lobes`: {integer >= 2, default 4} Number of lobes.
- `lobe_depth`: {0 < depth < 0.5, default 0.13} Lobe depth as a fraction of the mean radius.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.
- `phase`: {angle, default 0} Pair motion phase in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0, default undef} Additional radial root clearance in mm.
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

### Function `_cg_lobed_build`


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

### Function `_cg_lobed_pair_build`


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

### Function `_cg_lobed_unit_radius`


Evaluate the unit radial modulation r=s(1+d cos(kθ)) of a harmonic lobed pitch curve, whose teeth are placed by arc length.

**Parameters:**

- `lobes`: {integer >= 1} Number of radial lobes.
- `lobe_depth`: {0 <= d < 1} Radial modulation depth.
- `theta`: {angle} Polar angle in degrees.

**Returns:**

- `{number}`: Unit radius at the requested angle.

Back to [module description](#module-lobed).


Back to [top](#).

## Module `Harmonic common`


Coefficients are [harmonic, amplitude, phase in degrees]. Family adapters
own admissibility, pitch scaling and sampling; this evaluator does not
inherit the public Fourier family's coefficient-domain restrictions.

### Brief content:

**Functions**:

> [`_cg_harmonic_unit_radius`](#function-_cg_harmonic_unit_radius): Evaluate a finite cosine series around unit mean radius.


## Functions

The module `Harmonic common` defines the following functions.

### Function `_cg_harmonic_unit_radius`


Evaluate a finite cosine series around unit mean radius.

**Parameters:**

- `coefficients`: {array} Harmonic, amplitude and phase rows.
- `theta`: {angle} Physical polar angle in degrees.

**Returns:**

- `{number}`: Unit radius before family-specific scaling.

Back to [module description](#module-harmonic-common).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
