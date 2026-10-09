# Logistic Dwell

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Logistic Dwell`


The unit law is `r(theta)=1+0.2/(1+exp(-8*sin(2 theta)))-0.1`.
The logistic gate creates a controlled dwell and rapid-return interval.
Reference: https://en.wikipedia.org/wiki/Logistic_function.

### Brief content:

**Functions**:

> [`curve_gear_logistic_dwell`](#function-curve_gear_logistic_dwell): Build a logistic-gated second-harmonic dwell gear.

> [`curve_gear_logistic_dwell_2d`](#function-curve_gear_logistic_dwell_2d): Build the Logistic Dwell 2D outline.

> [`curve_gear_logistic_dwell_body`](#function-curve_gear_logistic_dwell_body): Build the Logistic Dwell body.

> [`curve_gear_logistic_dwell_body_2d`](#function-curve_gear_logistic_dwell_body_2d): Build the Logistic Dwell 2D body outline.

> [`curve_gear_logistic_dwell_centre_distance`](#function-curve_gear_logistic_dwell_centre_distance): Return the Logistic Dwell centre distance.

> [`curve_gear_logistic_dwell_mate`](#function-curve_gear_logistic_dwell_mate): Build a Logistic Dwell mating gear.

> [`curve_gear_logistic_dwell_mate_rotation`](#function-curve_gear_logistic_dwell_mate_rotation): Return the Logistic Dwell mate rotation for a driver phase.

> [`curve_gear_logistic_dwell_pair`](#function-curve_gear_logistic_dwell_pair): Build a Logistic Dwell gear pair.

> [`_cg_logistic_dwell_parameters_valid`](#function-_cg_logistic_dwell_parameters_valid): Check the shared curve-parameter contract for every family entry point.

> [`_cg_logistic_dwell_shape`](#function-_cg_logistic_dwell_shape): Bind the named curve once for driver, mate and numeric consumers.


## Functions

The module `Logistic Dwell` defines the following functions.

### Function `curve_gear_logistic_dwell`

| Logistic Dwell gear 1 | Logistic Dwell gear 2 |
| --- | --- |
| [![Logistic Dwell gear 1](../images/functions/logistic_dwell/curve_gear_logistic_dwell.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell.png) | [![Logistic Dwell gear 2](../images/functions/logistic_dwell/curve_gear_logistic_dwell_alternative.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_alternative.png) |


Depth 0.46 and gain 3 replace the canonical shallow, steep logistic gate. The larger radial variation and smoother transitions distinguish curve amplitude from gate sharpness; coarse teeth expose the contour.













**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `gain`: {number > 0, default 8} Logistic transition gain.
- `depth`: {0 < number < 0.5, default 0.2} Radial dwell depth.
- `pressure_angle`: {angle, default 20} Pressure angle.
- `tooth_phase`: {angle, default 0} Tooth phase.
- `backlash`: {undef or >= 0} Backlash.
- `clearance`: {undef or >= 0} Clearance.
- `samples`: {integer >= 120, default 720} Samples.
- `orientation`: {angle, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_2d`

| Logistic Dwell 2D gear 1 | Logistic Dwell 2D gear 2 |
| --- | --- |
| [![Logistic Dwell 2D gear 1](../images/functions/logistic_dwell/curve_gear_logistic_dwell_2d.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_2d.png) | [![Logistic Dwell 2D gear 2](../images/functions/logistic_dwell/curve_gear_logistic_dwell_alternative_2d.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_alternative_2d.png) |


Alternative 2 uses the contrasting controls described in the gear example.


**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `bore`: {number} Bore.
- `gain`: {number} Logistic gain.
- `depth`: {number} Dwell depth.
- `pressure_angle`: {number} Pressure angle.
- `tooth_phase`: {number} Tooth phase.
- `backlash`: {number} Backlash.
- `clearance`: {number} Clearance.
- `samples`: {integer} Samples.
- `orientation`: {number} Orientation.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_body`

| Logistic Dwell body 1 | Logistic Dwell body 2 |
| --- | --- |
| [![Logistic Dwell body 1](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body.png) | [![Logistic Dwell body 2](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative.png) |


Alternative 2 uses the contrasting controls described in the gear example.


**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `gain`: {number} Logistic gain.
- `depth`: {number} Dwell depth.
- `pressure_angle`: {number} Pressure angle.
- `tooth_phase`: {number} Tooth phase.
- `backlash`: {number} Backlash.
- `clearance`: {number} Clearance.
- `samples`: {integer} Samples.
- `orientation`: {number} Orientation.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_body_2d`

| Logistic Dwell 2D body 1 | Logistic Dwell 2D body 2 |
| --- | --- |
| [![Logistic Dwell 2D body 1](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_2d.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_2d.png) | [![Logistic Dwell 2D body 2](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative_2d.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative_2d.png) |


Alternative 2 uses the contrasting controls described in the gear example.


**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `bore`: {number} Bore.
- `gain`: {number} Logistic gain.
- `depth`: {number} Dwell depth.
- `pressure_angle`: {number} Pressure angle.
- `tooth_phase`: {number} Tooth phase.
- `backlash`: {number} Backlash.
- `clearance`: {number} Clearance.
- `samples`: {integer} Samples.
- `orientation`: {number} Orientation.
- `body_offset`: {number} Body offset.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_centre_distance`








**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `gain`: {number} Logistic gain.
- `depth`: {number} Dwell depth.
- `samples`: {integer} Samples.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_mate`

| Logistic Dwell mate 1 | Logistic Dwell mate 2 |
| --- | --- |
| [![Logistic Dwell mate 1](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png) | [![Logistic Dwell mate 2](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.png) |


Alternative 2 uses the contrasting controls described in the gear example.


**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `gain`: {number} Logistic gain.
- `depth`: {number} Dwell depth.
- `pressure_angle`: {number} Pressure angle.
- `tooth_phase`: {number} Tooth phase.
- `backlash`: {number} Backlash.
- `clearance`: {number} Clearance.
- `samples`: {integer} Samples.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_mate_rotation`









**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `gain`: {number} Logistic gain.
- `depth`: {number} Dwell depth.
- `samples`: {integer} Samples.
- `phase`: {number} Driver phase.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_pair`

| Logistic Dwell pair 1 | Logistic Dwell pair 2 |
| --- | --- |
| [![Logistic Dwell pair 1](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair.png) | [![Logistic Dwell pair 2](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair_alternative.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair_alternative.png) |


Alternative 2 separates the driver and mate and uses the contrasting gear controls described above.


**Parameters:**

- `modul`: {number, default .8} Tooth module.
- `tooth_number`: {integer, default 34} Tooth count.
- `width`: {number, default 4} Width.
- `bore`: {number, default 4.8} Bore.
- `gain`: {number, default 8} Logistic gain.
- `depth`: {number, default .2} Dwell depth.
- `pressure_angle`: {number, default 20} Pressure angle.
- `samples`: {integer, default 720} Samples.
- `phase`: {number, default 0} Pair phase.
- `together_built`: {boolean, default true} Mesh pair.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `tooth_phase`: {number, default 0} Tooth phase.
- `driver_color`: {string, default "SteelBlue"} Driver colour.
- `mate_color`: {string, default "Gold"} Mate colour.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `_cg_logistic_dwell_parameters_valid`


Check the shared curve-parameter contract for every family entry point.

**Parameters:**

- `gain`: {number > 0} Curve parameter.
- `depth`: {number between 0 and 0.5} Curve parameter.

**Returns:**

- `{boolean}`: True when all curve parameters are supported.

Back to [module description](#module-logistic-dwell).

### Function `_cg_logistic_dwell_shape`


Bind the named curve once for driver, mate and numeric consumers.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `gain`: {number} Named curve control.
- `depth`: {number} Named curve control.
- `samples`: {integer, default 720} Curve and motion sampling count.

**Returns:**

- `{array}`: Shared polar shape descriptor; the family owns only its mathematical controls.

Back to [module description](#module-logistic-dwell).


Back to [top](#).

## Module `Mate preparation`


Families own their radius laws, sampling and distance bounds. This layer
composes the existing solver and integration once per invocation.

### Brief content:

**Functions**:

> [`_cg_mate_distance_from_radii`](#function-_cg_mate_distance_from_radii): Solve the existing rolling equation after checking its physical bracket.

> [`_cg_mate_preparation`](#function-_cg_mate_preparation): Share distance, motion integration and conjugate pitch construction.

> [`_cg_mate_radii_valid`](#function-_cg_mate_radii_valid): Check finite positive physical radii without building geometry.

> [`_cg_polar_mate_distance`](#function-_cg_polar_mate_distance): Solve one named shape's physical centre distance without building unused geometry.

> [`_cg_polar_mate_rotation`](#function-_cg_polar_mate_rotation): Solve distance and integrated rolling motion for a named shape and phase.


## Functions

The module `Mate preparation` defines the following functions.

### Function `_cg_mate_distance_from_radii`


Solve the existing rolling equation after checking its physical bracket.

**Parameters:**

- `mid_radii`: {array of number} Physical radii at integration midpoints.
- `lower`: {number or function} Lower distance bound strictly above the midpoint radii.
- `upper`: {number} Upper distance bound enclosing one-turn closure.

**Returns:**

- `{number}`: Solved centre distance in millimetres.

Back to [module description](#module-mate-preparation).

### Function `_cg_mate_preparation`


Share distance, motion integration and conjugate pitch construction.

**Parameters:**

- `driver_radii`: {array of number} Radii at output angle boundaries.
- `mid_radii`: {array of number} Radii at the corresponding interval midpoints.
- `lower`: {number, function or undef} Family-selected lower solver bound.
- `upper`: {number or undef} Family-selected upper solver bound.
- `distance`: {number or undef} Optional already solved centre distance.

**Returns:**

- `{array}`: `[distance, motion table, mate pitch points]`, consumed by shared geometry operators.

Back to [module description](#module-mate-preparation).

### Function `_cg_mate_radii_valid`


Check finite positive physical radii without building geometry.

**Parameters:**

- `radii`: {array of number} Boundary or midpoint radii in millimetres.

**Returns:**

- `{boolean}`: True for at least three finite positive radii.

Back to [module description](#module-mate-preparation).

### Function `_cg_polar_mate_distance`


Solve one named shape's physical centre distance without building unused geometry.

**Parameters:**

- `shape`: {array} `[driver points, radius function, lower bound, upper bound, radial root]`.
- `n`: {integer >= 3} Number of motion intervals.

**Returns:**

- `{number}`: Centre distance in millimetres.

Back to [module description](#module-mate-preparation).

### Function `_cg_polar_mate_rotation`


Solve distance and integrated rolling motion for a named shape and phase.

**Parameters:**

- `shape`: {array} Physical shape and bound descriptor.
- `n`: {integer >= 3} Number of motion intervals.
- `phase`: {angle} Unwrapped driver phase in degrees.

**Returns:**

- `{angle}`: Mate display rotation in degrees.

Back to [module description](#module-mate-preparation).


Back to [top](#).

## Module `Saturating common`


Family adapters own parameter validation, correction harmonics and scaling.

### Brief content:

**Functions**:

> [`_cg_saturating_unit_radius`](#function-_cg_saturating_unit_radius): Evaluate a bounded tanh modulation around unit mean radius.


## Functions

The module `Saturating common` defines the following functions.

### Function `_cg_saturating_unit_radius`


Evaluate a bounded tanh modulation around unit mean radius.

**Parameters:**

- `theta`: {angle} Physical polar angle in degrees.
- `harmonic`: {integer > 0} Number of modulation periods per turn.
- `transition`: {number > 0} Saturation transition gain.
- `amplitude`: {number} Signed modulation amplitude.

**Returns:**

- `{number}`: Unit radius using the existing non-overflowing tanh helper.

Back to [module description](#module-saturating-common).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
