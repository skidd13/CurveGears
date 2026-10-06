# Cosine Quintic

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Cosine Quintic`

Signed fifth-power cosine polar pitch curves.

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


## Functions

The module `Cosine Quintic` defines the following functions.

### Function `curve_gear_cosine_quintic`

| Cosine Quintic gear preview | ⠀ |
| --- | --- |
| [![Cosine Quintic gear preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build a signed fifth-power cosine gear.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_2d`

| Cosine Quintic 2D outline | Full size |
| --- | --- |
| [![Cosine Quintic 2D outline](../images/functions/cosine_quintic/curve_gear_cosine_quintic_2d.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_2d.png) | [Open full-size image](../images/functions/cosine_quintic/curve_gear_cosine_quintic_2d.png) ![](../images/table-spacer.png) |


Build the Cosine Quintic 2D outline.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_body`

| Cosine Quintic body preview | Full size |
| --- | --- |
| [![Cosine Quintic body preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body.png) | [Open full-size image](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body.png) ![](../images/table-spacer.png) |


Build the Cosine Quintic body.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_body_2d`

| Cosine Quintic 2D body outline | Full size |
| --- | --- |
| [![Cosine Quintic 2D body outline](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_2d.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_2d.png) | [Open full-size image](../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_2d.png) ![](../images/table-spacer.png) |


Build the Cosine Quintic 2D body outline.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation. @param body_offset {number} Body offset.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_centre_distance`


Return the Cosine Quintic centre distance.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param samples {integer} Samples.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_mate`

| Cosine Quintic mate preview | Full size |
| --- | --- |
| [![Cosine Quintic mate preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate.png) | [Open full-size image](../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate.png) ![](../images/table-spacer.png) |


Build a Cosine Quintic mating gear.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_mate_rotation`


Return the Cosine Quintic mate rotation.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param samples {integer} Samples. @param phase {number} Driver phase.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).

### Function `curve_gear_cosine_quintic_pair`

| Cosine Quintic pair preview | Full size |
| --- | --- |
| [![Cosine Quintic pair preview](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png)](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png) | [Open full-size image](../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png) ![](../images/table-spacer.png) |


Build a Cosine Quintic gear pair.

**Parameters:**

- `modul`: {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param samples {integer} Samples. @param phase {number} Pair phase. @param together_built {boolean} Mesh pair. @param backlash {number} Backlash. @param clearance {number} Clearance. @param tooth_phase {number} Tooth phase. @param driver_color {string} Driver colour. @param mate_color {string} Mate colour.

**Returns:**

No return

Back to [module description](#module-cosine-quintic).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
