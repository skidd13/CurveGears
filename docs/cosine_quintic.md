# Cosine Quintic

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate preparation](mate-preparation.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)
  - [Harmonic common](harmonic-common.md) · [Trochoid common](trochoid-common.md) · [Saturating common](saturating-common.md)


## Module `Cosine Quintic`


The unit law is `r(theta)=1+0.19*sgn(cos(2 theta))*abs(cos(2 theta))^5`.
The odd signed power preserves continuity while flattening the plateaux.
Reference: https://en.wikipedia.org/wiki/Power_function.

### Brief content:

**Functions**:

> [`curve_gear_cosine_quintic`](#function-curve_gear_cosine_quintic): Build a signed fifth-power cosine gear.

> [`curve_gear_cosine_quintic_2d`](#function-curve_gear_cosine_quintic_2d): Build the Cosine Quintic 2D outline.

> [`curve_gear_cosine_quintic_body`](#function-curve_gear_cosine_quintic_body): Build the Cosine Quintic body.

> [`curve_gear_cosine_quintic_body_2d`](#function-curve_gear_cosine_quintic_body_2d): Build the Cosine Quintic 2D body outline.

> [`curve_gear_cosine_quintic_centre_distance`](#function-curve_gear_cosine_quintic_centre_distance): Return the Cosine Quintic centre distance.

> [`curve_gear_cosine_quintic_mate`](#function-curve_gear_cosine_quintic_mate): Build a Cosine Quintic mating gear.

> [`curve_gear_cosine_quintic_mate_rotation`](#function-curve_gear_cosine_quintic_mate_rotation): Return the Cosine Quintic mate rotation.

> [`curve_gear_cosine_quintic_pair`](#function-curve_gear_cosine_quintic_pair): Build a Cosine Quintic gear pair.

> [`_cg_cosine_quintic_parameters_valid`](#function-_cg_cosine_quintic_parameters_valid): Check the shared curve-parameter contract for every family entry point.

> [`_cg_cosine_quintic_shape`](#function-_cg_cosine_quintic_shape): Bind the named curve once for driver, mate and numeric consumers.

> [`_cg_cosine_quintic_unit_radius`](#function-_cg_cosine_quintic_unit_radius): Evaluate the signed fifth-power cosine radius law.


## Functions

The module `Cosine Quintic` defines the following functions.

### Function `curve_gear_cosine_quintic`

| Cosine Quintic gear 1 | Cosine Quintic gear 2 |
| --- | --- |
| [![cosine quintic example preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic.png) | [![Cosine Quintic gear alternative](../images/functions/cosine_quintic/curve_gear_cosine_quintic_alternative.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_alternative.png) |


Three pronounced signed-cosine plateaux replace the canonical two-harmonic form. Harmonic 3 and depth 0.16 expose how the fifth power concentrates the radial excursions.


**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_2d`

| Cosine Quintic 2D gear 1 | Cosine Quintic 2D gear 2 |
| --- | --- |
| [![cosine quintic 2d example preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_2d.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_2d.png) | [![Cosine Quintic 2D gear alternative](../images/functions/cosine_quintic/curve_gear_cosine_quintic_alternative_2d.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_alternative_2d.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `bore`: {number} Bore.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_body`

| Cosine Quintic body 1 | Cosine Quintic body 2 |
| --- | --- |
| [![cosine quintic body example preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body.png) | [![Cosine Quintic body alternative](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_body_2d`

| Cosine Quintic 2D body 1 | Cosine Quintic 2D body 2 |
| --- | --- |
| [![cosine quintic body 2d example preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_2d.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_2d.png) | [![Cosine Quintic 2D body alternative](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative_2d.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative_2d.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `bore`: {number} Bore.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.
- `body_offset`: {number, default 0} Body offset.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_centre_distance`




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `samples`: {integer, default 720} Samples.

**Returns:**

- `{number}`: Mathematical centre distance in mm.

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_mate`

| Cosine Quintic mate 1 | Cosine Quintic mate 2 |
| --- | --- |
| [![cosine quintic mate example preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate.png) | [![Cosine Quintic mate alternative](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate_alternative.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate_alternative.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_mate_rotation`




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
- `samples`: {integer, default 720} Samples.
- `phase`: {number, default 0} Driver phase.

**Returns:**

- `{angle}`: Mate rotation in degrees.

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_pair`

| Cosine Quintic pair 1 | Cosine Quintic pair 2 |
| --- | --- |
| [![cosine quintic pair example preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png) | [![Cosine Quintic pair alternative](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.png) |




**Parameters:**

- `modul`: {number, default .8} Tooth module.
- `tooth_number`: {integer, default 34} Tooth count.
- `width`: {number, default 4} Width.
- `bore`: {number, default 4.8} Bore.
- `depth`: {number, default .19} Quintic depth.
- `harmonic`: {integer, default 2} Cosine harmonic.
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

Back to [module description](#module-cosine-quintic).

### Function `_cg_cosine_quintic_parameters_valid`


Check the shared curve-parameter contract for every family entry point.

**Parameters:**

- `depth`: {number between 0 and 0.5} Curve parameter.
- `harmonic`: {integer >= 1} Curve parameter.

**Returns:**

- `{boolean}`: True when all curve parameters are supported.

Back to [module description](#module-cosine-quintic).

### Function `_cg_cosine_quintic_shape`


Bind the named curve once for driver, mate and numeric consumers.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `depth`: {number} Named curve control.
- `harmonic`: {number} Named curve control.
- `samples`: {integer, default 720} Curve and motion sampling count.

**Returns:**

- `{array}`: Shared polar shape descriptor; the family owns only its mathematical controls.

Back to [module description](#module-cosine-quintic).

### Function `_cg_cosine_quintic_unit_radius`


Evaluate the signed fifth-power cosine radius law.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-cosine-quintic).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
