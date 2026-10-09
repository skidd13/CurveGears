# Fourier

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Fourier`


Each coefficient is [harmonic, amplitude, phase]. Harmonics are positive
integers, amplitudes are fractions of the mean pitch radius, and phases are
degrees. The radius is R(1 + sum(amplitude*cos(harmonic*theta+phase))).
This is the exact analytic model; the implementation samples it into a
polyline because OpenSCAD polygon/extrusion inputs are discrete. Increase
samples for high harmonics or large amplitudes; the positive-radius bound
is a validation limit, not a physical guarantee. Reference:
https://mathworld.wolfram.com/FourierSeries.html.

### Brief content:

**Functions**:

> [`curve_gear_fourier`](#function-curve_gear_fourier): Build a coefficient-driven Fourier gear.

> [`curve_gear_fourier_2d`](#function-curve_gear_fourier_2d): Emit the complete fourier gear profile as 2D geometry.

> [`curve_gear_fourier_body`](#function-curve_gear_fourier_body): Build the Fourier body without teeth.

> [`curve_gear_fourier_body_2d`](#function-curve_gear_fourier_body_2d): Emit the fourier body as 2D geometry with an optional signed outer-contour offset.

> [`curve_gear_fourier_centre_distance`](#function-curve_gear_fourier_centre_distance): Return the Fourier conjugate pair centre distance.

> [`curve_gear_fourier_mate`](#function-curve_gear_fourier_mate): Build the standalone dynamically conjugate Fourier mate.

> [`curve_gear_fourier_mate_rotation`](#function-curve_gear_fourier_mate_rotation): Return Fourier mate rotation for a driver phase.

> [`curve_gear_fourier_pair`](#function-curve_gear_fourier_pair): Build a meshed or separated Fourier pair using one shared motion table.

> [`_cg_fourier_build`](#function-_cg_fourier_build): Internal fourier construction dispatcher.

> [`_cg_fourier_coefficients_valid`](#function-_cg_fourier_coefficients_valid): Validate integer harmonics and bounded positive-radius amplitudes.

> [`_cg_fourier_point`](#function-_cg_fourier_point): Evaluate a Fourier pitch point in Cartesian coordinates.

> [`_cg_fourier_points`](#function-_cg_fourier_points): Sample a complete Fourier pitch curve.

> [`_cg_fourier_radius`](#function-_cg_fourier_radius): Evaluate a Fourier polar radius at an angle.


## Functions

The module `Fourier` defines the following functions.

### Function `curve_gear_fourier`

| Fourier gear 1 | Fourier gear 2 |
| --- | --- |
| [![curve_gear_fourier example preview](../images/functions/fourier/curve_gear_fourier.png)](../images/functions/fourier/curve_gear_fourier.png) | [![Fourier gear alternative](../images/functions/fourier/curve_gear_fourier_alternative.png)](../images/functions/fourier/curve_gear_fourier_alternative.png) |


A single strong third harmonic produces three clear lobes instead of the canonical mixed second/third-harmonic oval. This isolates harmonic count from mixed-phase asymmetry.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `coefficients`: {array of [harmonic, amplitude, phase]} Polar harmonics relative to the mean pitch radius.
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
curve_gear_fourier(1, 24, 4, 8, [[2, .10, 0], [3, .04, 30]]);
~~~

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_2d`

| Fourier 2D gear 1 | Fourier 2D gear 2 |
| --- | --- |
| [![fourier 2D gear outline](../images/functions/fourier/curve_gear_fourier_2d.png)](../images/functions/fourier/curve_gear_fourier_2d.png) | [![Fourier 2D gear alternative](../images/functions/fourier/curve_gear_fourier_alternative_2d.png)](../images/functions/fourier/curve_gear_fourier_alternative_2d.png) |


Emit the complete fourier gear profile as 2D geometry.

**Parameters:**

- `modul`: {value} Tooth module in mm.
- `tooth_number`: {value} Number of teeth.
- `bore`: {value} Centre bore diameter in mm.
- `coefficients`: {value} Same family-specific parameter as curve_gear_fourier.
- `pressure_angle`: {value} Same family-specific parameter as curve_gear_fourier.
- `tooth_phase`: {value} Same family-specific parameter as curve_gear_fourier.
- `backlash`: {value} Same family-specific parameter as curve_gear_fourier.
- `clearance`: {value} Same family-specific parameter as curve_gear_fourier.
- `samples`: {value} Same family-specific parameter as curve_gear_fourier.
- `orientation`: {value} Rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_fourier_2d(0.8, 34, 4.8);
~~~

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_body`

| Fourier body 1 | Fourier body 2 |
| --- | --- |
| [![curve_gear_fourier_body example preview](../images/functions/fourier/curve_gear_fourier_body.png)](../images/functions/fourier/curve_gear_fourier_body.png) | [![Fourier body alternative](../images/functions/fourier/curve_gear_fourier_body_alternative.png)](../images/functions/fourier/curve_gear_fourier_body_alternative.png) |


Build the Fourier body without teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `coefficients`: {array of [harmonic, amplitude, phase]} Polar harmonics relative to the mean pitch radius.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 720} Pitch-curve sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_body_2d`

| Fourier 2D body 1 | Fourier 2D body 2 |
| --- | --- |
| [![fourier 2D body outline](../images/functions/fourier/curve_gear_fourier_body_2d.png)](../images/functions/fourier/curve_gear_fourier_body_2d.png) | [![Fourier 2D body alternative](../images/functions/fourier/curve_gear_fourier_body_alternative_2d.png)](../images/functions/fourier/curve_gear_fourier_body_alternative_2d.png) |


Emit the fourier body as 2D geometry with an optional signed outer-contour offset.

**Parameters:**

- `modul`: {value} Tooth module in mm.
- `tooth_number`: {value} Number of teeth.
- `bore`: {value} Centre bore diameter in mm.
- `coefficients`: {value} Same family-specific parameter as curve_gear_fourier_body.
- `pressure_angle`: {value} Same family-specific parameter as curve_gear_fourier_body.
- `tooth_phase`: {value} Same family-specific parameter as curve_gear_fourier_body.
- `backlash`: {value} Same family-specific parameter as curve_gear_fourier_body.
- `clearance`: {value} Same family-specific parameter as curve_gear_fourier_body.
- `samples`: {value} Same family-specific parameter as curve_gear_fourier_body.
- `orientation`: {value} Rotation in degrees.
- `body_offset`: {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.

**Returns:**

No return

### Example:

~~~c
curve_gear_fourier_body_2d(0.8, 34, 4.8, body_offset=-2);
~~~

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_centre_distance`


Return the Fourier conjugate pair centre distance.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `coefficients`: {array of [harmonic, amplitude, phase]} Same coefficients as the driver.
- `samples`: {integer >= 120, default 360} Motion-table sampling density.

**Returns:**

- `{number}`: Pair centre distance in mm.

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_mate`

| Fourier mate 1 | Fourier mate 2 |
| --- | --- |
| [![curve_gear_fourier_mate example preview](../images/functions/fourier/curve_gear_fourier_mate.png)](../images/functions/fourier/curve_gear_fourier_mate.png) | [![Fourier mate alternative](../images/functions/fourier/curve_gear_fourier_mate_alternative.png)](../images/functions/fourier/curve_gear_fourier_mate_alternative.png) |


Build the standalone dynamically conjugate Fourier mate.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `coefficients`: {array of [harmonic, amplitude, phase]} Same polar coefficients as the driver.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 360} Pitch-curve sampling density.

**Returns:**

No return

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_mate_rotation`


Return Fourier mate rotation for a driver phase.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `coefficients`: {array of [harmonic, amplitude, phase]} Same coefficients as the driver.
- `samples`: {integer >= 120, default 360} Motion-table sampling density.
- `phase`: {angle, default 0} Driver phase in degrees; negative and full-turn phases remain unwrapped.

**Returns:**

- `{angle}`: Mate rotation in degrees.

Back to [module description](#module-fourier).

### Function `curve_gear_fourier_pair`

| Fourier pair 1 | Fourier pair 2 |
| --- | --- |
| [![curve_gear_fourier_pair example preview](../images/functions/fourier/curve_gear_fourier_pair.png)](../images/functions/fourier/curve_gear_fourier_pair.png) | [![Fourier pair alternative](../images/functions/fourier/curve_gear_fourier_pair_alternative.png)](../images/functions/fourier/curve_gear_fourier_pair_alternative.png) |


Build a meshed or separated Fourier pair using one shared motion table.

**Parameters:**

- `modul`: {number > 0, default .8} Tooth module in mm.
- `tooth_number`: {integer >= 3, default 34} Number of teeth.
- `width`: {number > 0, default 4} Extrusion width in mm.
- `bore`: {number >= 0, default 4.8} Centre bore diameter in mm.
- `coefficients`: {array of [harmonic, amplitude, phase], default [[2,.10,0]]} Same polar coefficients as the driver.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `samples`: {integer >= 120, default 360} Pitch-curve sampling density.
- `phase`: {angle, default 0} Driver motion phase in degrees.
- `together_built`: {boolean, default true} Place the pair meshed when true.
- `backlash`: {undef or >= 0, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0, default undef} Additional radial root clearance in mm.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver display colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate display colour.

**Returns:**

No return

### Example:

~~~c
curve_gear_fourier_pair(1, 24, 4, 8, [[2, .10, 0], [3, .04, 30]]);
~~~

Back to [module description](#module-fourier).

### Function `_cg_fourier_build`


Internal fourier construction dispatcher.

**Parameters:**

- `modul`: {number} Tooth module in mm.
- `tooth_number`: {integer} Number of teeth.
- `width`: {number} Extrusion width in mm.
- `bore`: {number} Centre bore diameter in mm.
- `coefficients`: {value, default [[2,.10,0]]} Internal construction parameter.
- `pressure_angle`: {number, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {number, default 0} Tooth placement phase in degrees.
- `backlash`: {number, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {number, default undef} Additional radial root clearance in mm.
- `samples`: {integer, default 720} Pitch-curve or motion-table sampling density.
- `orientation`: {number, default 0} Single-gear display rotation in degrees.
- `body_only`: {boolean, default false} Emit the body without teeth.

**Returns:**

- `{geometry}`: Constructed family geometry.

Back to [module description](#module-fourier).

### Function `_cg_fourier_coefficients_valid`


Validate integer harmonics and bounded positive-radius amplitudes.

**Parameters:**

- `coefficients`: {array of [integer, number, angle]} Polar harmonics.

**Returns:**

- `{boolean}`: True when the coefficient list is valid.

Back to [module description](#module-fourier).

### Function `_cg_fourier_point`


Evaluate a Fourier pitch point in Cartesian coordinates.

**Parameters:**

- `base`: {number > 0} Base polar radius.
- `coefficients`: {array of [integer, number, angle]} Polar harmonics.
- `theta`: {angle} Polar angle in degrees.

**Returns:**

- `{point}`: Cartesian pitch point.

Back to [module description](#module-fourier).

### Function `_cg_fourier_points`


Sample a complete Fourier pitch curve.

**Parameters:**

- `base`: {number > 0} Base polar radius.
- `coefficients`: {array of [integer, number, angle]} Polar harmonics.
- `samples`: {integer >= 1} Number of output samples.

**Returns:**

- `{array of points}`: Sampled Cartesian pitch curve.

Back to [module description](#module-fourier).

### Function `_cg_fourier_radius`


Evaluate a Fourier polar radius at an angle.

**Parameters:**

- `base`: {number > 0} Base polar radius.
- `coefficients`: {array of [integer, number, angle]} Polar harmonics.
- `theta`: {angle} Polar angle in degrees.

**Returns:**

- `{number}`: Polar radius.

Back to [module description](#module-fourier).


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
