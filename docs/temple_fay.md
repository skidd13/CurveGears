# Temple Fay

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


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

> [`curve_gear_temple_fay_centre_distance`](#function-curve_gear_temple_fay_centre_distance): Return the Temple Fay reference centre distance.

> [`curve_gear_temple_fay_mate`](#function-curve_gear_temple_fay_mate): Build a separated Temple Fay mate presentation.

> [`curve_gear_temple_fay_mate_rotation`](#function-curve_gear_temple_fay_mate_rotation): Return the Temple Fay reference mate rotation.

> [`curve_gear_temple_fay_pair`](#function-curve_gear_temple_fay_pair): Build a separated Temple Fay reference pair; this family is not asserted as a conjugate transmission.


## Functions

The module `Temple Fay` defines the following functions.

### Function `curve_gear_temple_fay`

| Temple Fay gear preview | ⠀ |
| --- | --- |
| [![Temple Fay gear preview](../images/functions/temple_fay/curve_gear_temple_fay.png)](../images/functions/temple_fay/curve_gear_temple_fay.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build a Temple Fay butterfly-inspired gear.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_2d`

| Temple Fay 2D outline | Full size |
| --- | --- |
| [![Temple Fay 2D outline](../images/functions/temple_fay/curve_gear_temple_fay_2d.png)](../images/functions/temple_fay/curve_gear_temple_fay_2d.png) | [Open full-size image](../images/functions/temple_fay/curve_gear_temple_fay_2d.png) ![](../images/table-spacer.png) |


Build the Temple Fay 2D outline.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_body`

| Temple Fay body preview | Full size |
| --- | --- |
| [![Temple Fay body preview](../images/functions/temple_fay/curve_gear_temple_fay_body.png)](../images/functions/temple_fay/curve_gear_temple_fay_body.png) | [Open full-size image](../images/functions/temple_fay/curve_gear_temple_fay_body.png) ![](../images/table-spacer.png) |


Build the Temple Fay body.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_body_2d`

| Temple Fay 2D body outline | Full size |
| --- | --- |
| [![Temple Fay 2D body outline](../images/functions/temple_fay/curve_gear_temple_fay_body_2d.png)](../images/functions/temple_fay/curve_gear_temple_fay_body_2d.png) | [Open full-size image](../images/functions/temple_fay/curve_gear_temple_fay_body_2d.png) ![](../images/table-spacer.png) |


Build the Temple Fay 2D body outline.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation. @param body_offset {number} Body offset.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_centre_distance`


Return the Temple Fay reference centre distance.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param samples {integer} Samples.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_mate`

| Temple Fay mate preview | Full size |
| --- | --- |
| [![Temple Fay mate preview](../images/functions/temple_fay/curve_gear_temple_fay_mate.png)](../images/functions/temple_fay/curve_gear_temple_fay_mate.png) | [Open full-size image](../images/functions/temple_fay/curve_gear_temple_fay_mate.png) ![](../images/table-spacer.png) |


Build a separated Temple Fay mate presentation.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_mate_rotation`


Return the Temple Fay reference mate rotation.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param samples {integer} Samples. @param phase {number} Driver phase.

**Returns:**

No return

Back to [module description](#module-temple-fay).

### Function `curve_gear_temple_fay_pair`

| Temple Fay pair preview | Full size |
| --- | --- |
| [![Temple Fay pair preview](../images/functions/temple_fay/curve_gear_temple_fay_pair.png)](../images/functions/temple_fay/curve_gear_temple_fay_pair.png) | [Open full-size image](../images/functions/temple_fay/curve_gear_temple_fay_pair.png) ![](../images/table-spacer.png) |


Build a separated Temple Fay reference pair; this family is not asserted as a conjugate transmission.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param wing {number} Wing amplitude. @param fold {number} Fold harmonic. @param pressure_angle {number} Pressure angle. @param samples {integer} Samples. @param phase {number} Pair phase. @param together_built {boolean} Reference placement. @param backlash {number} Backlash. @param clearance {number} Clearance. @param tooth_phase {number} Tooth phase. @param driver_color {string} Driver colour. @param mate_color {string} Mate colour.

**Returns:**

No return

Back to [module description](#module-temple-fay).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
