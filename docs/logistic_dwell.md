# Logistic Dwell

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Logistic Dwell`

Logistic-gated second-harmonic polar pitch curves.

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


## Functions

The module `Logistic Dwell` defines the following functions.

### Function `curve_gear_logistic_dwell`

| Logistic Dwell gear preview | ⠀ |
| --- | --- |
| [![Logistic Dwell gear preview](../images/functions/logistic_dwell/curve_gear_logistic_dwell.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build a logistic-gated second-harmonic dwell gear.

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

| Logistic Dwell 2D outline | Full size |
| --- | --- |
| [![Logistic Dwell 2D outline](../images/functions/logistic_dwell/curve_gear_logistic_dwell_2d.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_2d.png) | [Open full-size image](../images/functions/logistic_dwell/curve_gear_logistic_dwell_2d.png) ![](../images/table-spacer.png) |


Build the Logistic Dwell 2D outline.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param gain {number} Logistic gain. @param depth {number} Dwell depth. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_body`

| Logistic Dwell body preview | Full size |
| --- | --- |
| [![Logistic Dwell body preview](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body.png) | [Open full-size image](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body.png) ![](../images/table-spacer.png) |


Build the Logistic Dwell body.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param gain {number} Logistic gain. @param depth {number} Dwell depth. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_body_2d`

| Logistic Dwell 2D body outline | Full size |
| --- | --- |
| [![Logistic Dwell 2D body outline](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_2d.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_2d.png) | [Open full-size image](../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_2d.png) ![](../images/table-spacer.png) |


Build the Logistic Dwell 2D body outline.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param gain {number} Logistic gain. @param depth {number} Dwell depth. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation. @param body_offset {number} Body offset.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_centre_distance`


Return the Logistic Dwell centre distance.

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

| Logistic Dwell mate preview | Full size |
| --- | --- |
| [![Logistic Dwell mate preview](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png) | [Open full-size image](../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png) ![](../images/table-spacer.png) |


Build a Logistic Dwell mating gear.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param gain {number} Logistic gain. @param depth {number} Dwell depth. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).

### Function `curve_gear_logistic_dwell_mate_rotation`


Return the Logistic Dwell mate rotation for a driver phase.

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

| Logistic Dwell pair preview | Full size |
| --- | --- |
| [![Logistic Dwell pair preview](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair.png)](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair.png) | [Open full-size image](../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair.png) ![](../images/table-spacer.png) |


Build a Logistic Dwell gear pair.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param gain {number} Logistic gain. @param depth {number} Dwell depth. @param pressure_angle {number} Pressure angle. @param samples {integer} Samples. @param phase {number} Pair phase. @param together_built {boolean} Mesh pair. @param backlash {number} Backlash. @param clearance {number} Clearance. @param tooth_phase {number} Tooth phase. @param driver_color {string} Driver colour. @param mate_color {string} Mate colour.

**Returns:**

No return

Back to [module description](#module-logistic-dwell).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
