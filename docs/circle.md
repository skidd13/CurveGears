# Circle

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Circle`


Circle is the constant-radius reference family. Its public gear, body,
mate, centre-distance, and pair APIs provide the control case for the same
construction contracts used by the non-circular families.

### Brief content:

**Functions**:

> [`curve_gear_circle(modul, tooth_number, width, bore, ...)`](#function-curve_gear_circlemodul-tooth_number-width-bore-): Build a circular reference gear.

> [`curve_gear_circle_2d(modul, tooth_number, bore, ...)`](#function-curve_gear_circle_2dmodul-tooth_number-bore-): Emit the complete circular gear profile as 2D geometry.

> [`curve_gear_circle_body(modul, tooth_number, width, bore, samples=480)`](#function-curve_gear_circle_bodymodul-tooth_number-width-bore-samples480): Build the circular reference body without teeth.

> [`curve_gear_circle_body_2d(modul, tooth_number, bore, samples=480, body_offset=0)`](#function-curve_gear_circle_body_2dmodul-tooth_number-bore-samples480-body_offset0): Emit the circular body as 2D geometry; negative body_offset shrinks its outer contour.

> [`curve_gear_circle_centre_distance(modul, tooth_number)`](#function-curve_gear_circle_centre_distancemodul-tooth_number): Return the reference centre distance for a circular pair.

> [`curve_gear_circle_mate(modul, tooth_number, width, bore, ...)`](#function-curve_gear_circle_matemodul-tooth_number-width-bore-): Build the circular reference mate boundary at the origin.

> [`curve_gear_circle_pair(modul, tooth_number, width, bore, ...)`](#function-curve_gear_circle_pairmodul-tooth_number-width-bore-): Build a meshed or separated circular reference pair.

> [`_cg_circle_points(modul, tooth_number, samples=480)`](#function-_cg_circle_pointsmodul-tooth_number-samples480): Sample the circular pitch curve in angular order.

> [`_cg_circle_radius(modul, tooth_number)`](#function-_cg_circle_radiusmodul-tooth_number): Calculate the circular pitch radius from module and tooth count.


## Functions

The module `Circle` defines the following functions.

### Function `curve_gear_circle(modul, tooth_number, width, bore, ...)`

| Circle gear preview | ⠀ |
| --- | --- |
| [![Circle gear preview](../images/functions/circle/curve_gear_circle.png)](../images/functions/circle/curve_gear_circle.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build a circular reference gear.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 480} Circular pitch-curve sampling density.

**Returns:**

No return

Back to [module description](#module-circle).

### Function `curve_gear_circle_2d(modul, tooth_number, bore, ...)`

| Circle 2D gear outline | ⠀ |
| --- | --- |
| [![Circle 2D gear outline](../images/functions/circle/curve_gear_circle_2d.png)](../images/functions/circle/curve_gear_circle_2d.png) | [![⠀](../utils/doxydown-support/table-spacer-512.png)](../utils/doxydown-support/table-spacer-512.png) |


Emit the complete circular gear profile as 2D geometry.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {angle, default 20} Involute pressure angle.
- `tooth_phase`: {angle, default 0} Tooth placement phase.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 120, default 480} Pitch-curve sampling density.

**Returns:**

No return

### Example:

~~~c
curve_gear_circle_2d(0.8, 34, 4.8);
~~~

Back to [module description](#module-circle).

### Function `curve_gear_circle_body(modul, tooth_number, width, bore, samples=480)`

| Circle body preview | ⠀ |
| --- | --- |
| [![Circle body preview](../images/functions/circle/curve_gear_circle_body.png)](../images/functions/circle/curve_gear_circle_body.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build the circular reference body without teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `samples`: {integer >= 120, default 480} Circular pitch-curve sampling density.

**Returns:**

No return

Back to [module description](#module-circle).

### Function `curve_gear_circle_body_2d(modul, tooth_number, bore, samples=480, body_offset=0)`

| Circle 2D body outline | ⠀ |
| --- | --- |
| [![Circle 2D body outline](../images/functions/circle/curve_gear_circle_body_2d.png)](../images/functions/circle/curve_gear_circle_body_2d.png) | [![⠀](../utils/doxydown-support/table-spacer-512.png)](../utils/doxydown-support/table-spacer-512.png) |


Emit the circular body as 2D geometry; negative body_offset shrinks its outer contour.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `samples`: {integer >= 120, default 480} Pitch-curve sampling density.
- `body_offset`: {number, default 0} Signed outer-contour offset in mm; the bore is preserved.

**Returns:**

No return

### Example:

~~~c
curve_gear_circle_body_2d(0.8, 34, 4.8, body_offset=-2);
~~~

Back to [module description](#module-circle).

### Function `curve_gear_circle_centre_distance(modul, tooth_number)`


Return the reference centre distance for a circular pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.

**Returns:**

- `{number}`: Pair centre distance in mm.

Back to [module description](#module-circle).

### Function `curve_gear_circle_mate(modul, tooth_number, width, bore, ...)`

| Circle mate preview | ⠀ |
| --- | --- |
| [![Circle mate preview](../images/functions/circle/curve_gear_circle_mate.png)](../images/functions/circle/curve_gear_circle_mate.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build the circular reference mate boundary at the origin.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 480} Circular pitch-curve sampling density.

**Returns:**

No return

Back to [module description](#module-circle).

### Function `curve_gear_circle_pair(modul, tooth_number, width, bore, ...)`

| Circle pair preview | ⠀ |
| --- | --- |
| [![Circle pair preview](../images/functions/circle/curve_gear_circle_pair.png)](../images/functions/circle/curve_gear_circle_pair.png) | [![⠀](../utils/doxydown-support/table-spacer.png)](../utils/doxydown-support/table-spacer.png) |


Build a meshed or separated circular reference pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `samples`: {integer >= 120, default 480} Circular pitch-curve sampling density.
- `phase`: {angle, default 0} Driver motion phase in degrees.
- `together_built`: {boolean, default true} Place the pair meshed when true, separated when false.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver display colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate display colour.

**Returns:**

No return

Back to [module description](#module-circle).

### Function `_cg_circle_points(modul, tooth_number, samples=480)`


Sample the circular pitch curve in angular order.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3} Number of teeth.
- `samples`: {integer >= 1, default 480} Number of pitch-curve samples.

**Returns:**

- `{array of points}`: Closed circular pitch curve in millimetres.

Back to [module description](#module-circle).

### Function `_cg_circle_radius(modul, tooth_number)`


Calculate the circular pitch radius from module and tooth count.

**Parameters:**

- `modul`: {number > 0} Tooth module in millimetres.
- `tooth_number`: {integer >= 3} Number of teeth.

**Returns:**

- `{number}`: Pitch radius in millimetres.

Back to [module description](#module-circle).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
