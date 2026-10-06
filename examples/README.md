# Executable API examples

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](../docs/bezier.md) · [Cassini](../docs/cassini.md) · [Circle](../docs/circle.md) · [Cusp](../docs/cusp.md) · [Ellipse](../docs/ellipse.md) · [Epitrochoid](../docs/epitrochoid.md)
  - [Fourier](../docs/fourier.md) · [Hypotrochoid](../docs/hypotrochoid.md) · [Lobed](../docs/lobed.md) · [Logarithmic spiral](../docs/logarithmic_spiral.md) · [Pascal](../docs/pascal.md) · [Superformula](../docs/superformula.md)
- Shared
  - [Examples catalogue](README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](../docs/tooth-construction.md) · [Tooth placement](../docs/tooth-placement.md) · [Mate motion](../docs/mate-motion.md) · [Mate generation](../docs/mate-generation.md) · [Pair assembly](../docs/pair-assembly.md)


Each entry is catalogued as a function in one Doxydown examples module. The source link is authoritative; generated images remain beside the corresponding example.

## Module `Executable examples`

Executable examples for the public API and shared construction layers.

### Brief content:

**Functions**:

> [`bezier_curve_gear`](#function-bezier_curve_gear): Render a smooth asymmetric Bézier gear with a soft teardrop outline.

> [`bezier_curve_gear_alternative`](#function-bezier_curve_gear_alternative): Bézier asymmetric alternative: A visibly non-circular but radially admissible Bézier pitch curve.

> [`bezier_curve_gear_body`](#function-bezier_curve_gear_body): Render the Bézier body before tooth placement.

> [`bezier_curve_gear_mate`](#function-bezier_curve_gear_mate): Render the conjugate Bézier mate generated from the driver pitch curve.

> [`bezier_curve_gear_pair`](#function-bezier_curve_gear_pair): Render a complete Bézier gear pair with derived conjugate motion.

> [`bezier_curve_gear_pair_alternative`](#function-bezier_curve_gear_pair_alternative): Bézier asymmetric pair alternative: The same visibly non-circular Bézier curve and its derived mate.

> [`cassini_curve_gear`](#function-cassini_curve_gear): Render a thin-waisted peanut-shaped Cassini gear.

> [`cassini_curve_gear_body`](#function-cassini_curve_gear_body): Render the Cassini body before tooth placement.

> [`cassini_curve_gear_centre_distance`](#function-cassini_curve_gear_centre_distance): Show the Cassini centre-distance calculation used for pair placement.

> [`cassini_curve_gear_mate`](#function-cassini_curve_gear_mate): Render the conjugate Cassini mate generated from the driver pitch curve.

> [`cassini_curve_gear_mate_rotation`](#function-cassini_curve_gear_mate_rotation): Show the Cassini mate-rotation calculation used for pair assembly.

> [`cassini_curve_gear_pair`](#function-cassini_curve_gear_pair): Render a complete Cassini gear pair with derived conjugate motion.

> [`circle_curve_gear`](#function-circle_curve_gear): Render a Circle gear from the documented pitch-curve family.

> [`circle_curve_gear_body`](#function-circle_curve_gear_body): Render the Circle body before tooth placement.

> [`circle_curve_gear_mate`](#function-circle_curve_gear_mate): Render the conjugate Circle mate generated from the driver pitch curve.

> [`circle_curve_gear_pair`](#function-circle_curve_gear_pair): Render a complete Circle gear pair with derived conjugate motion.

> [`curve_gear_bezier_2d`](#function-curve_gear_bezier_2d): Render the complete bezier gear profile as flat 2D geometry.

> [`curve_gear_bezier_body_2d`](#function-curve_gear_bezier_body_2d): Render the bezier body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_cassini_2d`](#function-curve_gear_cassini_2d): Render the complete cassini gear profile as flat 2D geometry.

> [`curve_gear_cassini_body_2d`](#function-curve_gear_cassini_body_2d): Render the cassini body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_circle_2d`](#function-curve_gear_circle_2d): Render the complete circle gear profile as flat 2D geometry.

> [`curve_gear_circle_body_2d`](#function-curve_gear_circle_body_2d): Render the circle body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_cusp_2d`](#function-curve_gear_cusp_2d): Render the complete cusp gear profile as flat 2D geometry.

> [`curve_gear_cusp_body_2d`](#function-curve_gear_cusp_body_2d): Render the cusp body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_ellipse_2d`](#function-curve_gear_ellipse_2d): Render the complete ellipse gear profile as flat 2D geometry.

> [`curve_gear_ellipse_body_2d`](#function-curve_gear_ellipse_body_2d): Render the ellipse body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_epitrochoid_2d`](#function-curve_gear_epitrochoid_2d): Render the complete epitrochoid gear profile as flat 2D geometry.

> [`curve_gear_epitrochoid_body_2d`](#function-curve_gear_epitrochoid_body_2d): Render the epitrochoid body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_fourier_2d`](#function-curve_gear_fourier_2d): Render the complete fourier gear profile as flat 2D geometry.

> [`curve_gear_fourier_body_2d`](#function-curve_gear_fourier_body_2d): Render the fourier body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_hypotrochoid_2d`](#function-curve_gear_hypotrochoid_2d): Render the complete hypotrochoid gear profile as flat 2D geometry.

> [`curve_gear_hypotrochoid_body_2d`](#function-curve_gear_hypotrochoid_body_2d): Render the hypotrochoid body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_lobed_2d`](#function-curve_gear_lobed_2d): Render the complete lobed gear profile as flat 2D geometry.

> [`curve_gear_lobed_body_2d`](#function-curve_gear_lobed_body_2d): Render the lobed body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_logarithmic_spiral_2d`](#function-curve_gear_logarithmic_spiral_2d): Render the complete logarithmic_spiral gear profile as flat 2D geometry.

> [`curve_gear_logarithmic_spiral_body_2d`](#function-curve_gear_logarithmic_spiral_body_2d): Render the logarithmic_spiral body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_pascal_2d`](#function-curve_gear_pascal_2d): Render the complete pascal gear profile as flat 2D geometry.

> [`curve_gear_pascal_body_2d`](#function-curve_gear_pascal_body_2d): Render the pascal body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`curve_gear_superformula_2d`](#function-curve_gear_superformula_2d): Render the complete superformula gear profile as flat 2D geometry.

> [`curve_gear_superformula_body_2d`](#function-curve_gear_superformula_body_2d): Render the superformula body as flat 2D geometry with a 2 mm inward outer-contour shrink.

> [`cusp_curve_gear`](#function-cusp_curve_gear): Render the three-cusp gear with radial teeth whose roots follow the cusp branches.

> [`cusp_curve_gear_body`](#function-cusp_curve_gear_body): Render the three-cusp deltoid body with its integrated cusp-tip teeth.

> [`cusp_curve_gear_centre_distance`](#function-cusp_curve_gear_centre_distance): Show the solved centre distance for the deltoid cusp pair.

> [`cusp_curve_gear_mate`](#function-cusp_curve_gear_mate): Render the standalone deltoid cusp gear mate.

> [`cusp_curve_gear_mate_rotation`](#function-cusp_curve_gear_mate_rotation): Show the calculated mate rotation at 45 degrees of driver motion.

> [`cusp_curve_gear_pair`](#function-cusp_curve_gear_pair): Render the deltoid cusp gear with its conjugate motion mate.

> [`ellipse_curve_gear`](#function-ellipse_curve_gear): Render a Ellipse gear from the documented pitch-curve family.

> [`ellipse_curve_gear_body`](#function-ellipse_curve_gear_body): Render the Ellipse body before tooth placement.

> [`ellipse_curve_gear_centre_distance`](#function-ellipse_curve_gear_centre_distance): Show the Ellipse centre-distance calculation used for pair placement.

> [`ellipse_curve_gear_mate`](#function-ellipse_curve_gear_mate): Render the conjugate Ellipse mate generated from the driver pitch curve.

> [`ellipse_curve_gear_mate_rotation`](#function-ellipse_curve_gear_mate_rotation): Show the Ellipse mate-rotation calculation used for pair assembly.

> [`ellipse_curve_gear_pair`](#function-ellipse_curve_gear_pair): Render a complete Ellipse gear pair with derived conjugate motion.

> [`epitrochoid_curve_gear`](#function-epitrochoid_curve_gear): Render a scalloped Epitrochoid gear showing the rolling-pen profile.

> [`epitrochoid_curve_gear_body`](#function-epitrochoid_curve_gear_body): Render the Epitrochoid body before tooth placement.

> [`epitrochoid_curve_gear_centre_distance`](#function-epitrochoid_curve_gear_centre_distance): Show the Epitrochoid centre-distance calculation used for pair placement.

> [`epitrochoid_curve_gear_mate`](#function-epitrochoid_curve_gear_mate): Render the conjugate Epitrochoid mate generated from the driver pitch curve.

> [`epitrochoid_curve_gear_mate_rotation`](#function-epitrochoid_curve_gear_mate_rotation): Show the Epitrochoid mate-rotation calculation used for pair assembly.

> [`epitrochoid_curve_gear_pair`](#function-epitrochoid_curve_gear_pair): Render a complete Epitrochoid gear pair with derived conjugate motion.

> [`fourier_curve_gear`](#function-fourier_curve_gear): Render a two-harmonic Fourier gear with visibly modulated lobes.

> [`fourier_curve_gear_body`](#function-fourier_curve_gear_body): Render the Fourier body before tooth placement.

> [`fourier_curve_gear_centre_distance`](#function-fourier_curve_gear_centre_distance): Show the Fourier centre-distance calculation used for pair placement.

> [`fourier_curve_gear_mate`](#function-fourier_curve_gear_mate): Render the conjugate Fourier mate generated from the driver pitch curve.

> [`fourier_curve_gear_mate_rotation`](#function-fourier_curve_gear_mate_rotation): Show the Fourier mate-rotation calculation used for pair assembly.

> [`fourier_curve_gear_pair`](#function-fourier_curve_gear_pair): Render a complete Fourier gear pair with derived conjugate motion.

> [`hypotrochoid_curve_gear`](#function-hypotrochoid_curve_gear): Render a triangular inner-rolling Hypotrochoid form.

> [`hypotrochoid_curve_gear_body`](#function-hypotrochoid_curve_gear_body): Render the Hypotrochoid body before tooth placement.

> [`hypotrochoid_curve_gear_centre_distance`](#function-hypotrochoid_curve_gear_centre_distance): Show the Hypotrochoid centre-distance calculation used for pair placement.

> [`hypotrochoid_curve_gear_mate`](#function-hypotrochoid_curve_gear_mate): Render the conjugate Hypotrochoid mate generated from the driver pitch curve.

> [`hypotrochoid_curve_gear_mate_rotation`](#function-hypotrochoid_curve_gear_mate_rotation): Show the Hypotrochoid mate-rotation calculation used for pair assembly.

> [`hypotrochoid_curve_gear_pair`](#function-hypotrochoid_curve_gear_pair): Render a complete Hypotrochoid gear pair with derived conjugate motion.

> [`hypotrochoid_curve_gear_pair_alternative`](#function-hypotrochoid_curve_gear_pair_alternative): curve_gear_hypotrochoid_pair alternative: Executable example for curve gear hypotrochoid pair alternative.

> [`lobed_curve_gear`](#function-lobed_curve_gear): Render a square four-lobed gear with a clear radial rhythm.

> [`lobed_curve_gear_body`](#function-lobed_curve_gear_body): Render the Lobed body before tooth placement.

> [`lobed_curve_gear_centre_distance`](#function-lobed_curve_gear_centre_distance): Show the Lobed centre-distance calculation used for pair placement.

> [`lobed_curve_gear_mate`](#function-lobed_curve_gear_mate): Render the conjugate Lobed mate generated from the driver pitch curve.

> [`lobed_curve_gear_mate_rotation`](#function-lobed_curve_gear_mate_rotation): Show the Lobed mate-rotation calculation used for pair assembly.

> [`lobed_curve_gear_pair`](#function-lobed_curve_gear_pair): Render a complete Lobed gear pair with derived conjugate motion.

> [`logarithmic_spiral_curve_gear`](#function-logarithmic_spiral_curve_gear): Render a Logarithmic spiral gear from the documented pitch-curve family.

> [`logarithmic_spiral_curve_gear_body`](#function-logarithmic_spiral_curve_gear_body): Render the Logarithmic spiral body before tooth placement.

> [`logarithmic_spiral_curve_gear_mate`](#function-logarithmic_spiral_curve_gear_mate): Render the conjugate Logarithmic spiral mate generated from the driver pitch curve.

> [`logarithmic_spiral_curve_gear_pair`](#function-logarithmic_spiral_curve_gear_pair): Render a complete Logarithmic spiral gear pair with derived conjugate motion.

> [`logarithmic_spiral_curve_gear_reference_separation`](#function-logarithmic_spiral_curve_gear_reference_separation): Show the Logarithmic spiral reference-separation calculation.

> [`pascal_curve_gear`](#function-pascal_curve_gear): Render a heart-like Pascal gear with a pronounced non-convex waist.

> [`pascal_curve_gear_body`](#function-pascal_curve_gear_body): Render the Pascal body before tooth placement.

> [`pascal_curve_gear_centre_distance`](#function-pascal_curve_gear_centre_distance): Show the Pascal centre-distance calculation used for pair placement.

> [`pascal_curve_gear_mate`](#function-pascal_curve_gear_mate): Render the conjugate Pascal mate generated from the driver pitch curve.

> [`pascal_curve_gear_mate_rotation`](#function-pascal_curve_gear_mate_rotation): Show the Pascal mate-rotation calculation used for pair assembly.

> [`pascal_curve_gear_pair`](#function-pascal_curve_gear_pair): Render a complete Pascal gear pair with derived conjugate motion.

> [`superformula_curve_gear`](#function-superformula_curve_gear): Render a Superformula gear from the documented pitch-curve family.

> [`superformula_curve_gear_body`](#function-superformula_curve_gear_body): Render the Superformula body before tooth placement.

> [`superformula_curve_gear_centre_distance`](#function-superformula_curve_gear_centre_distance): Show the Superformula centre-distance calculation used for pair placement.

> [`superformula_curve_gear_mate`](#function-superformula_curve_gear_mate): Render the conjugate Superformula mate generated from the driver pitch curve.

> [`superformula_curve_gear_mate_rotation`](#function-superformula_curve_gear_mate_rotation): Show the Superformula mate-rotation calculation used for pair assembly.

> [`superformula_curve_gear_pair`](#function-superformula_curve_gear_pair): Render a complete Superformula gear pair with derived conjugate motion.

> [`tooth_assembly`](#function-tooth_assembly): Tooth assembly preview: Compare placed tooth boundaries with the final assembled outline.

> [`tooth_construction`](#function-tooth_construction): Tooth construction preview: Render one validated cached local tooth candidate.

> [`tooth_placement`](#function-tooth_placement): Tooth placement preview: Render cached teeth placed along a sinusoidal edge of a body.


## Functions

The module `Executable examples` defines the following functions.

### Function `bezier_curve_gear`

| curve_gear_bezier example preview | ⠀ |
| --- | --- |
| [![curve_gear_bezier example preview](../images/functions/bezier/curve_gear_bezier.png)](../images/functions/bezier/curve_gear_bezier.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/bezier/curve_gear_bezier.scad`](functions/bezier/curve_gear_bezier.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `bezier_curve_gear_alternative`

| Bézier asymmetric alternative preview | ⠀ |
| --- | --- |
| [![Bézier asymmetric alternative preview](../images/functions/bezier/curve_gear_bezier_alternative.png)](../images/functions/bezier/curve_gear_bezier_alternative.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/bezier/curve_gear_bezier_alternative.scad`](functions/bezier/curve_gear_bezier_alternative.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `bezier_curve_gear_body`

| curve_gear_bezier_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_bezier_body example preview](../images/functions/bezier/curve_gear_bezier_body.png)](../images/functions/bezier/curve_gear_bezier_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/bezier/curve_gear_bezier_body.scad`](functions/bezier/curve_gear_bezier_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `bezier_curve_gear_mate`

| curve_gear_bezier_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_bezier_mate example preview](../images/functions/bezier/curve_gear_bezier_mate.png)](../images/functions/bezier/curve_gear_bezier_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/bezier/curve_gear_bezier_mate.scad`](functions/bezier/curve_gear_bezier_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `bezier_curve_gear_pair`

| curve_gear_bezier_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_bezier_pair example preview](../images/functions/bezier/curve_gear_bezier_pair.png)](../images/functions/bezier/curve_gear_bezier_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/bezier/curve_gear_bezier_pair.scad`](functions/bezier/curve_gear_bezier_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `bezier_curve_gear_pair_alternative`

| Bézier asymmetric pair alternative preview | ⠀ |
| --- | --- |
| [![Bézier asymmetric pair alternative preview](../images/functions/bezier/curve_gear_bezier_pair_alternative.png)](../images/functions/bezier/curve_gear_bezier_pair_alternative.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/bezier/curve_gear_bezier_pair_alternative.scad`](functions/bezier/curve_gear_bezier_pair_alternative.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cassini_curve_gear`

| curve_gear_cassini example preview | ⠀ |
| --- | --- |
| [![curve_gear_cassini example preview](../images/functions/cassini/curve_gear_cassini.png)](../images/functions/cassini/curve_gear_cassini.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/cassini/curve_gear_cassini.scad`](functions/cassini/curve_gear_cassini.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cassini_curve_gear_body`

| curve_gear_cassini_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_cassini_body example preview](../images/functions/cassini/curve_gear_cassini_body.png)](../images/functions/cassini/curve_gear_cassini_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/cassini/curve_gear_cassini_body.scad`](functions/cassini/curve_gear_cassini_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cassini_curve_gear_centre_distance`


Source: [`functions/cassini/curve_gear_cassini_centre_distance.scad`](functions/cassini/curve_gear_cassini_centre_distance.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cassini_curve_gear_mate`

| curve_gear_cassini_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_cassini_mate example preview](../images/functions/cassini/curve_gear_cassini_mate.png)](../images/functions/cassini/curve_gear_cassini_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/cassini/curve_gear_cassini_mate.scad`](functions/cassini/curve_gear_cassini_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cassini_curve_gear_mate_rotation`


Source: [`functions/cassini/curve_gear_cassini_mate_rotation.scad`](functions/cassini/curve_gear_cassini_mate_rotation.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cassini_curve_gear_pair`

| curve_gear_cassini_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_cassini_pair example preview](../images/functions/cassini/curve_gear_cassini_pair.png)](../images/functions/cassini/curve_gear_cassini_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/cassini/curve_gear_cassini_pair.scad`](functions/cassini/curve_gear_cassini_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `circle_curve_gear`

| curve gear circle preview | ⠀ |
| --- | --- |
| [![curve gear circle preview](../images/functions/circle/curve_gear_circle.png)](../images/functions/circle/curve_gear_circle.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/circle/curve_gear_circle.scad`](functions/circle/curve_gear_circle.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `circle_curve_gear_body`

| curve gear circle body preview | ⠀ |
| --- | --- |
| [![curve gear circle body preview](../images/functions/circle/curve_gear_circle_body.png)](../images/functions/circle/curve_gear_circle_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/circle/curve_gear_circle_body.scad`](functions/circle/curve_gear_circle_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `circle_curve_gear_mate`

| curve gear circle mate preview | ⠀ |
| --- | --- |
| [![curve gear circle mate preview](../images/functions/circle/curve_gear_circle_mate.png)](../images/functions/circle/curve_gear_circle_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/circle/curve_gear_circle_mate.scad`](functions/circle/curve_gear_circle_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `circle_curve_gear_pair`

| curve gear circle pair preview | ⠀ |
| --- | --- |
| [![curve gear circle pair preview](../images/functions/circle/curve_gear_circle_pair.png)](../images/functions/circle/curve_gear_circle_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/circle/curve_gear_circle_pair.scad`](functions/circle/curve_gear_circle_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_bezier_2d`

| bezier 2D gear outline | ⠀ |
| --- | --- |
| [![bezier 2D gear outline](../images/functions/bezier/curve_gear_bezier_2d.png)](../images/functions/bezier/curve_gear_bezier_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/bezier/curve_gear_bezier_2d.scad`](functions/bezier/curve_gear_bezier_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_bezier_body_2d`

| bezier 2D body outline | ⠀ |
| --- | --- |
| [![bezier 2D body outline](../images/functions/bezier/curve_gear_bezier_body_2d.png)](../images/functions/bezier/curve_gear_bezier_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/bezier/curve_gear_bezier_body_2d.scad`](functions/bezier/curve_gear_bezier_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_cassini_2d`

| cassini 2D gear outline | ⠀ |
| --- | --- |
| [![cassini 2D gear outline](../images/functions/cassini/curve_gear_cassini_2d.png)](../images/functions/cassini/curve_gear_cassini_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/cassini/curve_gear_cassini_2d.scad`](functions/cassini/curve_gear_cassini_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_cassini_body_2d`

| cassini 2D body outline | ⠀ |
| --- | --- |
| [![cassini 2D body outline](../images/functions/cassini/curve_gear_cassini_body_2d.png)](../images/functions/cassini/curve_gear_cassini_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/cassini/curve_gear_cassini_body_2d.scad`](functions/cassini/curve_gear_cassini_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_circle_2d`

| circle 2D gear outline | ⠀ |
| --- | --- |
| [![circle 2D gear outline](../images/functions/circle/curve_gear_circle_2d.png)](../images/functions/circle/curve_gear_circle_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/circle/curve_gear_circle_2d.scad`](functions/circle/curve_gear_circle_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_circle_body_2d`

| circle 2D body outline | ⠀ |
| --- | --- |
| [![circle 2D body outline](../images/functions/circle/curve_gear_circle_body_2d.png)](../images/functions/circle/curve_gear_circle_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/circle/curve_gear_circle_body_2d.scad`](functions/circle/curve_gear_circle_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_cusp_2d`

| cusp 2D gear outline | ⠀ |
| --- | --- |
| [![cusp 2D gear outline](../images/functions/cusp/curve_gear_cusp_2d.png)](../images/functions/cusp/curve_gear_cusp_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/cusp/curve_gear_cusp_2d.scad`](functions/cusp/curve_gear_cusp_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_cusp_body_2d`

| cusp 2D body outline | ⠀ |
| --- | --- |
| [![cusp 2D body outline](../images/functions/cusp/curve_gear_cusp_body_2d.png)](../images/functions/cusp/curve_gear_cusp_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/cusp/curve_gear_cusp_body_2d.scad`](functions/cusp/curve_gear_cusp_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_ellipse_2d`

| ellipse 2D gear outline | ⠀ |
| --- | --- |
| [![ellipse 2D gear outline](../images/functions/ellipse/curve_gear_ellipse_2d.png)](../images/functions/ellipse/curve_gear_ellipse_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/ellipse/curve_gear_ellipse_2d.scad`](functions/ellipse/curve_gear_ellipse_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_ellipse_body_2d`

| ellipse 2D body outline | ⠀ |
| --- | --- |
| [![ellipse 2D body outline](../images/functions/ellipse/curve_gear_ellipse_body_2d.png)](../images/functions/ellipse/curve_gear_ellipse_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/ellipse/curve_gear_ellipse_body_2d.scad`](functions/ellipse/curve_gear_ellipse_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_epitrochoid_2d`

| epitrochoid 2D gear outline | ⠀ |
| --- | --- |
| [![epitrochoid 2D gear outline](../images/functions/epitrochoid/curve_gear_epitrochoid_2d.png)](../images/functions/epitrochoid/curve_gear_epitrochoid_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/epitrochoid/curve_gear_epitrochoid_2d.scad`](functions/epitrochoid/curve_gear_epitrochoid_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_epitrochoid_body_2d`

| epitrochoid 2D body outline | ⠀ |
| --- | --- |
| [![epitrochoid 2D body outline](../images/functions/epitrochoid/curve_gear_epitrochoid_body_2d.png)](../images/functions/epitrochoid/curve_gear_epitrochoid_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/epitrochoid/curve_gear_epitrochoid_body_2d.scad`](functions/epitrochoid/curve_gear_epitrochoid_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_fourier_2d`

| fourier 2D gear outline | ⠀ |
| --- | --- |
| [![fourier 2D gear outline](../images/functions/fourier/curve_gear_fourier_2d.png)](../images/functions/fourier/curve_gear_fourier_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/fourier/curve_gear_fourier_2d.scad`](functions/fourier/curve_gear_fourier_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_fourier_body_2d`

| fourier 2D body outline | ⠀ |
| --- | --- |
| [![fourier 2D body outline](../images/functions/fourier/curve_gear_fourier_body_2d.png)](../images/functions/fourier/curve_gear_fourier_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/fourier/curve_gear_fourier_body_2d.scad`](functions/fourier/curve_gear_fourier_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_hypotrochoid_2d`

| hypotrochoid 2D gear outline | ⠀ |
| --- | --- |
| [![hypotrochoid 2D gear outline](../images/functions/hypotrochoid/curve_gear_hypotrochoid_2d.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_2d.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_hypotrochoid_body_2d`

| hypotrochoid 2D body outline | ⠀ |
| --- | --- |
| [![hypotrochoid 2D body outline](../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_lobed_2d`

| lobed 2D gear outline | ⠀ |
| --- | --- |
| [![lobed 2D gear outline](../images/functions/lobed/curve_gear_lobed_2d.png)](../images/functions/lobed/curve_gear_lobed_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/lobed/curve_gear_lobed_2d.scad`](functions/lobed/curve_gear_lobed_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_lobed_body_2d`

| lobed 2D body outline | ⠀ |
| --- | --- |
| [![lobed 2D body outline](../images/functions/lobed/curve_gear_lobed_body_2d.png)](../images/functions/lobed/curve_gear_lobed_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/lobed/curve_gear_lobed_body_2d.scad`](functions/lobed/curve_gear_lobed_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_logarithmic_spiral_2d`

| logarithmic_spiral 2D gear outline | ⠀ |
| --- | --- |
| [![logarithmic_spiral 2D gear outline](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.png)](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_logarithmic_spiral_body_2d`

| logarithmic_spiral 2D body outline | ⠀ |
| --- | --- |
| [![logarithmic_spiral 2D body outline](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.png)](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_pascal_2d`

| pascal 2D gear outline | ⠀ |
| --- | --- |
| [![pascal 2D gear outline](../images/functions/pascal/curve_gear_pascal_2d.png)](../images/functions/pascal/curve_gear_pascal_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/pascal/curve_gear_pascal_2d.scad`](functions/pascal/curve_gear_pascal_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_pascal_body_2d`

| pascal 2D body outline | ⠀ |
| --- | --- |
| [![pascal 2D body outline](../images/functions/pascal/curve_gear_pascal_body_2d.png)](../images/functions/pascal/curve_gear_pascal_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/pascal/curve_gear_pascal_body_2d.scad`](functions/pascal/curve_gear_pascal_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_superformula_2d`

| superformula 2D gear outline | ⠀ |
| --- | --- |
| [![superformula 2D gear outline](../images/functions/superformula/curve_gear_superformula_2d.png)](../images/functions/superformula/curve_gear_superformula_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/superformula/curve_gear_superformula_2d.scad`](functions/superformula/curve_gear_superformula_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `curve_gear_superformula_body_2d`

| superformula 2D body outline | ⠀ |
| --- | --- |
| [![superformula 2D body outline](../images/functions/superformula/curve_gear_superformula_body_2d.png)](../images/functions/superformula/curve_gear_superformula_body_2d.png) | [![⠀](../images/table-spacer-512.png)](../images/table-spacer-512.png) |


Source: [`functions/superformula/curve_gear_superformula_body_2d.scad`](functions/superformula/curve_gear_superformula_body_2d.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cusp_curve_gear`


Source: [`cusp/curve_gear_cusp.scad`](cusp/curve_gear_cusp.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cusp_curve_gear_body`


Source: [`cusp/curve_gear_cusp_body.scad`](cusp/curve_gear_cusp_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cusp_curve_gear_centre_distance`


Source: [`cusp/curve_gear_cusp_centre_distance.scad`](cusp/curve_gear_cusp_centre_distance.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cusp_curve_gear_mate`


Source: [`cusp/curve_gear_cusp_mate.scad`](cusp/curve_gear_cusp_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cusp_curve_gear_mate_rotation`


Source: [`cusp/curve_gear_cusp_mate_rotation.scad`](cusp/curve_gear_cusp_mate_rotation.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `cusp_curve_gear_pair`


Source: [`cusp/curve_gear_cusp_pair.scad`](cusp/curve_gear_cusp_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `ellipse_curve_gear`

| curve_gear_ellipse example preview | ⠀ |
| --- | --- |
| [![curve_gear_ellipse example preview](../images/functions/ellipse/curve_gear_ellipse.png)](../images/functions/ellipse/curve_gear_ellipse.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/ellipse/curve_gear_ellipse.scad`](functions/ellipse/curve_gear_ellipse.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `ellipse_curve_gear_body`

| curve_gear_ellipse_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_ellipse_body example preview](../images/functions/ellipse/curve_gear_ellipse_body.png)](../images/functions/ellipse/curve_gear_ellipse_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/ellipse/curve_gear_ellipse_body.scad`](functions/ellipse/curve_gear_ellipse_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `ellipse_curve_gear_centre_distance`


Source: [`functions/ellipse/curve_gear_ellipse_centre_distance.scad`](functions/ellipse/curve_gear_ellipse_centre_distance.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `ellipse_curve_gear_mate`

| curve_gear_ellipse_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_ellipse_mate example preview](../images/functions/ellipse/curve_gear_ellipse_mate.png)](../images/functions/ellipse/curve_gear_ellipse_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/ellipse/curve_gear_ellipse_mate.scad`](functions/ellipse/curve_gear_ellipse_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `ellipse_curve_gear_mate_rotation`


Source: [`functions/ellipse/curve_gear_ellipse_mate_rotation.scad`](functions/ellipse/curve_gear_ellipse_mate_rotation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `ellipse_curve_gear_pair`

| curve_gear_ellipse_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_ellipse_pair example preview](../images/functions/ellipse/curve_gear_ellipse_pair.png)](../images/functions/ellipse/curve_gear_ellipse_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/ellipse/curve_gear_ellipse_pair.scad`](functions/ellipse/curve_gear_ellipse_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `epitrochoid_curve_gear`

| curve_gear_epitrochoid example preview | ⠀ |
| --- | --- |
| [![curve_gear_epitrochoid example preview](../images/functions/epitrochoid/curve_gear_epitrochoid.png)](../images/functions/epitrochoid/curve_gear_epitrochoid.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/epitrochoid/curve_gear_epitrochoid.scad`](functions/epitrochoid/curve_gear_epitrochoid.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `epitrochoid_curve_gear_body`

| curve_gear_epitrochoid_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_epitrochoid_body example preview](../images/functions/epitrochoid/curve_gear_epitrochoid_body.png)](../images/functions/epitrochoid/curve_gear_epitrochoid_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/epitrochoid/curve_gear_epitrochoid_body.scad`](functions/epitrochoid/curve_gear_epitrochoid_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `epitrochoid_curve_gear_centre_distance`


Source: [`functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad`](functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `epitrochoid_curve_gear_mate`

| curve_gear_epitrochoid_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_epitrochoid_mate example preview](../images/functions/epitrochoid/curve_gear_epitrochoid_mate.png)](../images/functions/epitrochoid/curve_gear_epitrochoid_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/epitrochoid/curve_gear_epitrochoid_mate.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `epitrochoid_curve_gear_mate_rotation`


Source: [`functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `epitrochoid_curve_gear_pair`

| curve_gear_epitrochoid_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_epitrochoid_pair example preview](../images/functions/epitrochoid/curve_gear_epitrochoid_pair.png)](../images/functions/epitrochoid/curve_gear_epitrochoid_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/epitrochoid/curve_gear_epitrochoid_pair.scad`](functions/epitrochoid/curve_gear_epitrochoid_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `fourier_curve_gear`

| curve_gear_fourier example preview | ⠀ |
| --- | --- |
| [![curve_gear_fourier example preview](../images/functions/fourier/curve_gear_fourier.png)](../images/functions/fourier/curve_gear_fourier.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/fourier/curve_gear_fourier.scad`](functions/fourier/curve_gear_fourier.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `fourier_curve_gear_body`

| curve_gear_fourier_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_fourier_body example preview](../images/functions/fourier/curve_gear_fourier_body.png)](../images/functions/fourier/curve_gear_fourier_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/fourier/curve_gear_fourier_body.scad`](functions/fourier/curve_gear_fourier_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `fourier_curve_gear_centre_distance`


Source: [`functions/fourier/curve_gear_fourier_centre_distance.scad`](functions/fourier/curve_gear_fourier_centre_distance.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `fourier_curve_gear_mate`

| curve_gear_fourier_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_fourier_mate example preview](../images/functions/fourier/curve_gear_fourier_mate.png)](../images/functions/fourier/curve_gear_fourier_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/fourier/curve_gear_fourier_mate.scad`](functions/fourier/curve_gear_fourier_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `fourier_curve_gear_mate_rotation`


Source: [`functions/fourier/curve_gear_fourier_mate_rotation.scad`](functions/fourier/curve_gear_fourier_mate_rotation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `fourier_curve_gear_pair`

| curve_gear_fourier_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_fourier_pair example preview](../images/functions/fourier/curve_gear_fourier_pair.png)](../images/functions/fourier/curve_gear_fourier_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/fourier/curve_gear_fourier_pair.scad`](functions/fourier/curve_gear_fourier_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear`

| curve_gear_hypotrochoid example preview | ⠀ |
| --- | --- |
| [![curve_gear_hypotrochoid example preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid.scad`](functions/hypotrochoid/curve_gear_hypotrochoid.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear_body`

| curve_gear_hypotrochoid_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_hypotrochoid_body example preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear_centre_distance`


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_centre_distance.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_centre_distance.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear_mate`

| curve_gear_hypotrochoid_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_hypotrochoid_mate example preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_mate.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear_mate_rotation`


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear_pair`

| curve_gear_hypotrochoid_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_hypotrochoid_pair example preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `hypotrochoid_curve_gear_pair_alternative`

| curve_gear_hypotrochoid_pair alternative preview | ⠀ |
| --- | --- |
| [![curve_gear_hypotrochoid_pair alternative preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.png)](../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `lobed_curve_gear`

| curve_gear_lobed example preview | ⠀ |
| --- | --- |
| [![curve_gear_lobed example preview](../images/functions/lobed/curve_gear_lobed.png)](../images/functions/lobed/curve_gear_lobed.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/lobed/curve_gear_lobed.scad`](functions/lobed/curve_gear_lobed.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `lobed_curve_gear_body`

| curve_gear_lobed_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_lobed_body example preview](../images/functions/lobed/curve_gear_lobed_body.png)](../images/functions/lobed/curve_gear_lobed_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/lobed/curve_gear_lobed_body.scad`](functions/lobed/curve_gear_lobed_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `lobed_curve_gear_centre_distance`


Source: [`functions/lobed/curve_gear_lobed_centre_distance.scad`](functions/lobed/curve_gear_lobed_centre_distance.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `lobed_curve_gear_mate`

| curve_gear_lobed_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_lobed_mate example preview](../images/functions/lobed/curve_gear_lobed_mate.png)](../images/functions/lobed/curve_gear_lobed_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/lobed/curve_gear_lobed_mate.scad`](functions/lobed/curve_gear_lobed_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `lobed_curve_gear_mate_rotation`


Source: [`functions/lobed/curve_gear_lobed_mate_rotation.scad`](functions/lobed/curve_gear_lobed_mate_rotation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `lobed_curve_gear_pair`

| curve_gear_lobed_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_lobed_pair example preview](../images/functions/lobed/curve_gear_lobed_pair.png)](../images/functions/lobed/curve_gear_lobed_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/lobed/curve_gear_lobed_pair.scad`](functions/lobed/curve_gear_lobed_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `logarithmic_spiral_curve_gear`

| curve_gear_logarithmic_spiral example preview | ⠀ |
| --- | --- |
| [![curve_gear_logarithmic_spiral example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png)](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `logarithmic_spiral_curve_gear_body`

| curve_gear_logarithmic_spiral_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_logarithmic_spiral_body example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png)](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `logarithmic_spiral_curve_gear_mate`

| curve_gear_logarithmic_spiral_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_logarithmic_spiral_mate example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.png)](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `logarithmic_spiral_curve_gear_pair`

| curve_gear_logarithmic_spiral_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_logarithmic_spiral_pair example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.png)](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `logarithmic_spiral_curve_gear_reference_separation`


Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `pascal_curve_gear`

| curve_gear_pascal example preview | ⠀ |
| --- | --- |
| [![curve_gear_pascal example preview](../images/functions/pascal/curve_gear_pascal.png)](../images/functions/pascal/curve_gear_pascal.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/pascal/curve_gear_pascal.scad`](functions/pascal/curve_gear_pascal.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `pascal_curve_gear_body`

| curve_gear_pascal_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_pascal_body example preview](../images/functions/pascal/curve_gear_pascal_body.png)](../images/functions/pascal/curve_gear_pascal_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/pascal/curve_gear_pascal_body.scad`](functions/pascal/curve_gear_pascal_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `pascal_curve_gear_centre_distance`


Source: [`functions/pascal/curve_gear_pascal_centre_distance.scad`](functions/pascal/curve_gear_pascal_centre_distance.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `pascal_curve_gear_mate`

| curve_gear_pascal_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_pascal_mate example preview](../images/functions/pascal/curve_gear_pascal_mate.png)](../images/functions/pascal/curve_gear_pascal_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/pascal/curve_gear_pascal_mate.scad`](functions/pascal/curve_gear_pascal_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `pascal_curve_gear_mate_rotation`


Source: [`functions/pascal/curve_gear_pascal_mate_rotation.scad`](functions/pascal/curve_gear_pascal_mate_rotation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `pascal_curve_gear_pair`

| curve_gear_pascal_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_pascal_pair example preview](../images/functions/pascal/curve_gear_pascal_pair.png)](../images/functions/pascal/curve_gear_pascal_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/pascal/curve_gear_pascal_pair.scad`](functions/pascal/curve_gear_pascal_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `superformula_curve_gear`

| curve_gear_superformula example preview | ⠀ |
| --- | --- |
| [![curve_gear_superformula example preview](../images/functions/superformula/curve_gear_superformula.png)](../images/functions/superformula/curve_gear_superformula.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/superformula/curve_gear_superformula.scad`](functions/superformula/curve_gear_superformula.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `superformula_curve_gear_body`

| curve_gear_superformula_body example preview | ⠀ |
| --- | --- |
| [![curve_gear_superformula_body example preview](../images/functions/superformula/curve_gear_superformula_body.png)](../images/functions/superformula/curve_gear_superformula_body.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/superformula/curve_gear_superformula_body.scad`](functions/superformula/curve_gear_superformula_body.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `superformula_curve_gear_centre_distance`


Source: [`functions/superformula/curve_gear_superformula_centre_distance.scad`](functions/superformula/curve_gear_superformula_centre_distance.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `superformula_curve_gear_mate`

| curve_gear_superformula_mate example preview | ⠀ |
| --- | --- |
| [![curve_gear_superformula_mate example preview](../images/functions/superformula/curve_gear_superformula_mate.png)](../images/functions/superformula/curve_gear_superformula_mate.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/superformula/curve_gear_superformula_mate.scad`](functions/superformula/curve_gear_superformula_mate.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `superformula_curve_gear_mate_rotation`


Source: [`functions/superformula/curve_gear_superformula_mate_rotation.scad`](functions/superformula/curve_gear_superformula_mate_rotation.scad)

The result is deliberately emitted as an OpenSCAD console value because
this callable returns a number rather than geometry.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `superformula_curve_gear_pair`

| curve_gear_superformula_pair example preview | ⠀ |
| --- | --- |
| [![curve_gear_superformula_pair example preview](../images/functions/superformula/curve_gear_superformula_pair.png)](../images/functions/superformula/curve_gear_superformula_pair.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`functions/superformula/curve_gear_superformula_pair.scad`](functions/superformula/curve_gear_superformula_pair.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `tooth_assembly`

| Tooth assembly preview preview | ⠀ |
| --- | --- |
| [![Tooth assembly preview preview](../images/tooth/assembly.png)](../images/tooth/assembly.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`tooth/assembly.scad`](tooth/assembly.scad)

The left panel keeps the canonical body and accepted placed tooth
boundaries separate. The right panel is the single outline returned by
_cg_final_outline_from_placements, so the body intervals replaced by teeth
can be checked as one continuous polygon.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `tooth_construction`

| Tooth construction preview preview | ⠀ |
| --- | --- |
| [![Tooth construction preview preview](../images/tooth/construction.png)](../images/tooth/construction.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`tooth/construction.scad`](tooth/construction.scad)

This is the standalone output of tooth/generation.scad. It is intentionally
local rather than attached to a curve, so the involute flanks and top
closure can be inspected without placement hiding their shape.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `tooth_placement`

| Tooth placement preview preview | ⠀ |
| --- | --- |
| [![Tooth placement preview preview](../images/tooth/placement.png)](../images/tooth/placement.png) | [![⠀](../images/table-spacer.png)](../images/table-spacer.png) |


Source: [`tooth/placement.scad`](tooth/placement.scad)

This diagnostic deliberately uses a rectangular body with a multi-period
sine-wave upper edge. Teeth are displayed only on that edge, so changing
tangents, normals, hills, valleys and source-point spacing can be inspected
without the rest of a closed gear hiding the placement behaviour. The body
is inset beneath the source curve, while the production tooth
boundary is shown in full so each tooth visibly stands on the edge.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
