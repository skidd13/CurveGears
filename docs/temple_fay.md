# Temple Fay

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate preparation](mate-preparation.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)
  - [Harmonic common](harmonic-common.md) · [Trochoid common](trochoid-common.md) · [Saturating common](saturating-common.md)


## Module `Temple Fay`


The project law is `r(theta)=1+0.18*sin(2 theta)+0.05*sin(4 theta)`.
It is a bounded two-harmonic Fourier polar curve inspired by the Butterfly
Curve associated with Temple H. Fay; this project name is intentional and
does not claim that the implementation is the historical curve itself.
Reference: https://mathworld.wolfram.com/ButterflyCurve.html and
https://en.wikipedia.org/wiki/Fourier_series.

### Brief content:

**Functions**:

> [`curve_gear_temple_fay`](#function-curve_gear_temple_fay): Build a Temple Fay butterfly-inspired gear.

> [`curve_gear_temple_fay_2d`](#function-curve_gear_temple_fay_2d): Build the Temple Fay 2D outline.

> [`curve_gear_temple_fay_body`](#function-curve_gear_temple_fay_body): Build the Temple Fay body.

> [`curve_gear_temple_fay_body_2d`](#function-curve_gear_temple_fay_body_2d): Build the Temple Fay 2D body outline.

> [`curve_gear_temple_fay_centre_distance`](#function-curve_gear_temple_fay_centre_distance): Solve the Temple Fay conjugate centre distance from rolling closure.

> [`curve_gear_temple_fay_mate`](#function-curve_gear_temple_fay_mate): Build the dynamically solved Temple Fay conjugate mate.

> [`curve_gear_temple_fay_mate_rotation`](#function-curve_gear_temple_fay_mate_rotation): Return the integrated Temple Fay conjugate mate rotation.

> [`curve_gear_temple_fay_pair`](#function-curve_gear_temple_fay_pair): Build a Temple Fay driver and dynamically solved conjugate mate, separated by default.

> [`_cg_temple_fay_shape`](#function-_cg_temple_fay_shape): Build the sampled Temple Fay pitch shape and radial bounds.

> [`_cg_temple_fay_unit_radius`](#function-_cg_temple_fay_unit_radius): Evaluate the project two-harmonic Temple Fay radius law.


## Functions

The module `Temple Fay` defines the following functions.

### Function `curve_gear_temple_fay`

| Temple Fay gear 1 | Temple Fay gear 2 |
| --- | --- |
| [![temple fay butterfly example preview](../images/functions/temple_fay/curve_gear_temple_fay.png)](../images/functions/temple_fay/curve_gear_temple_fay.png) | [![Temple Fay gear alternative](../images/functions/temple_fay/curve_gear_temple_fay_alternative.png)](../images/functions/temple_fay/curve_gear_temple_fay_alternative.png) |


The canonical example uses the broad wing 0.38 and fold 0.14 profile. Alternative standalone and pair examples use wing 0.18 and fold 0.05.


**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_2d`

| Temple Fay 2D gear 1 | Temple Fay 2D gear 2 |
| --- | --- |
| [![temple fay 2d example preview](../images/functions/temple_fay/curve_gear_temple_fay_2d.png)](../images/functions/temple_fay/curve_gear_temple_fay_2d.png) | [![Temple Fay 2D gear alternative](../images/functions/temple_fay/curve_gear_temple_fay_alternative_2d.png)](../images/functions/temple_fay/curve_gear_temple_fay_alternative_2d.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `bore`: {number} Bore.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_body`

| Temple Fay body 1 | Temple Fay body 2 |
| --- | --- |
| [![temple fay body example preview](../images/functions/temple_fay/curve_gear_temple_fay_body.png)](../images/functions/temple_fay/curve_gear_temple_fay_body.png) | [![Temple Fay body alternative](../images/functions/temple_fay/curve_gear_temple_fay_body_alternative.png)](../images/functions/temple_fay/curve_gear_temple_fay_body_alternative.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_body_2d`

| Temple Fay 2D body 1 | Temple Fay 2D body 2 |
| --- | --- |
| [![temple fay body 2d example preview](../images/functions/temple_fay/curve_gear_temple_fay_body_2d.png)](../images/functions/temple_fay/curve_gear_temple_fay_body_2d.png) | [![Temple Fay 2D body alternative](../images/functions/temple_fay/curve_gear_temple_fay_body_alternative_2d.png)](../images/functions/temple_fay/curve_gear_temple_fay_body_alternative_2d.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `bore`: {number} Bore.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.
- `orientation`: {number, default 0} Orientation.
- `body_offset`: {number, default 0} Body offset.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_centre_distance`




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `samples`: {integer, default 720} Samples.

**Returns:**

- `{number}`: Mathematical centre distance in mm.

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_mate`

| Temple Fay mate 1 | Temple Fay mate 2 |
| --- | --- |
| [![temple fay mate example preview](../images/functions/temple_fay/curve_gear_temple_fay_mate.png)](../images/functions/temple_fay/curve_gear_temple_fay_mate.png) | [![Temple Fay mate alternative](../images/functions/temple_fay/curve_gear_temple_fay_mate_alternative.png)](../images/functions/temple_fay/curve_gear_temple_fay_mate_alternative.png) |




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `width`: {number} Width.
- `bore`: {number} Bore.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `tooth_phase`: {number, default 0} Tooth phase.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `samples`: {integer, default 720} Samples.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_mate_rotation`




**Parameters:**

- `modul`: {number} Tooth module.
- `tooth_number`: {integer} Tooth count.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `samples`: {integer, default 720} Samples.
- `phase`: {number, default 0} Driver phase.

**Returns:**

- `{angle}`: Mate rotation in degrees.

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_pair`

| Temple Fay pair 1 | Temple Fay pair 2 |
| --- | --- |
| [![temple fay pair example preview](../images/functions/temple_fay/curve_gear_temple_fay_pair.png)](../images/functions/temple_fay/curve_gear_temple_fay_pair.png) | [![Temple Fay pair alternative](../images/functions/temple_fay/curve_gear_temple_fay_pair_alternative.png)](../images/functions/temple_fay/curve_gear_temple_fay_pair_alternative.png) |




**Parameters:**

- `modul`: {number, default .8} Tooth module.
- `tooth_number`: {integer, default 34} Tooth count.
- `width`: {number, default 4} Width.
- `bore`: {number, default 4.8} Bore.
- `wing`: {number, default .18} Wing amplitude.
- `fold`: {number, default .05} Fold harmonic.
- `pressure_angle`: {number, default 20} Pressure angle.
- `samples`: {integer, default 720} Samples.
- `phase`: {number, default 0} Pair phase.
- `together_built`: {boolean, default false} Use meshed placement when true, separated display placement otherwise.
- `backlash`: {number, default undef} Backlash.
- `clearance`: {number, default undef} Clearance.
- `tooth_phase`: {number, default 0} Driver tooth-placement phase.
- `driver_color`: {string, default "SteelBlue"} Driver colour.
- `mate_color`: {string, default "Gold"} Mate colour.
- `mate_tooth_phase_offset`: {number, default 0} Additional mate tooth-placement phase; 180 degrees is half a tooth.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `_cg_temple_fay_shape`


Build the sampled Temple Fay pitch shape and radial bounds.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `_cg_temple_fay_unit_radius`


Evaluate the project two-harmonic Temple Fay radius law.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-temple-fay).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
