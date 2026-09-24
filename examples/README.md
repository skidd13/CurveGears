# Executable API examples

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](../docs/bezier.md) · [Cassini](../docs/cassini.md) · [Circle](../docs/circle.md) · [Ellipse](../docs/ellipse.md) · [Epitrochoid](../docs/epitrochoid.md) · [Fourier](../docs/fourier.md)
  - [Hypotrochoid](../docs/hypotrochoid.md) · [Lobed](../docs/lobed.md) · [Logarithmic spiral](../docs/logarithmic_spiral.md) · [Pascal](../docs/pascal.md) · [Superformula](../docs/superformula.md)
- Shared
  - [Examples catalogue](README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](../docs/tooth-construction.md) · [Tooth placement](../docs/tooth-placement.md) · [Mate motion](../docs/mate-motion.md) · [Mate generation](../docs/mate-generation.md) · [Pair assembly](../docs/pair-assembly.md)


Each entry is catalogued as a function in one Doxydown examples module. The source link is authoritative; generated images remain beside the corresponding example.

## Module `Executable examples`

Executable examples for the public API and shared construction layers.

### Brief content:

**Functions**:

> [`example_functions_bezier_curve_gear_bezier`](#function-example_functions_bezier_curve_gear_bezier): [`functions/bezier/curve_gear_bezier.scad`](functions/bezier/curve_gear_bezier.scad) — curve_gear_bezier example: One-to-one executable example for the documented public API.

> [`example_functions_bezier_curve_gear_bezier_alternative`](#function-example_functions_bezier_curve_gear_bezier_alternative): [`functions/bezier/curve_gear_bezier_alternative.scad`](functions/bezier/curve_gear_bezier_alternative.scad) — Bézier asymmetric alternative: A visibly non-circular but radially admissible Bézier pitch curve.

> [`example_functions_bezier_curve_gear_bezier_body`](#function-example_functions_bezier_curve_gear_bezier_body): [`functions/bezier/curve_gear_bezier_body.scad`](functions/bezier/curve_gear_bezier_body.scad) — curve_gear_bezier_body example: One-to-one executable example for the documented public API.

> [`example_functions_bezier_curve_gear_bezier_mate`](#function-example_functions_bezier_curve_gear_bezier_mate): [`functions/bezier/curve_gear_bezier_mate.scad`](functions/bezier/curve_gear_bezier_mate.scad) — curve_gear_bezier_mate example: One-to-one executable example for the admissible Bézier mate API.

> [`example_functions_bezier_curve_gear_bezier_pair`](#function-example_functions_bezier_curve_gear_bezier_pair): [`functions/bezier/curve_gear_bezier_pair.scad`](functions/bezier/curve_gear_bezier_pair.scad) — curve_gear_bezier_pair example: One-to-one executable example for the Bézier pair API.

> [`example_functions_bezier_curve_gear_bezier_pair_alternative`](#function-example_functions_bezier_curve_gear_bezier_pair_alternative): [`functions/bezier/curve_gear_bezier_pair_alternative.scad`](functions/bezier/curve_gear_bezier_pair_alternative.scad) — Bézier asymmetric pair alternative: The same visibly non-circular Bézier curve and its derived mate.

> [`example_functions_cassini_curve_gear_cassini`](#function-example_functions_cassini_curve_gear_cassini): [`functions/cassini/curve_gear_cassini.scad`](functions/cassini/curve_gear_cassini.scad) — curve_gear_cassini example: One-to-one executable example for the documented public API.

> [`example_functions_cassini_curve_gear_cassini_body`](#function-example_functions_cassini_curve_gear_cassini_body): [`functions/cassini/curve_gear_cassini_body.scad`](functions/cassini/curve_gear_cassini_body.scad) — curve_gear_cassini_body example: One-to-one executable example for the documented public API.

> [`example_functions_cassini_curve_gear_cassini_centre_distance`](#function-example_functions_cassini_curve_gear_cassini_centre_distance): [`functions/cassini/curve_gear_cassini_centre_distance.scad`](functions/cassini/curve_gear_cassini_centre_distance.scad) — curve_gear_cassini_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_cassini_curve_gear_cassini_mate`](#function-example_functions_cassini_curve_gear_cassini_mate): [`functions/cassini/curve_gear_cassini_mate.scad`](functions/cassini/curve_gear_cassini_mate.scad) — curve_gear_cassini_mate example: One-to-one executable example for the documented public API.

> [`example_functions_cassini_curve_gear_cassini_mate_rotation`](#function-example_functions_cassini_curve_gear_cassini_mate_rotation): [`functions/cassini/curve_gear_cassini_mate_rotation.scad`](functions/cassini/curve_gear_cassini_mate_rotation.scad) — curve_gear_cassini_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_cassini_curve_gear_cassini_pair`](#function-example_functions_cassini_curve_gear_cassini_pair): [`functions/cassini/curve_gear_cassini_pair.scad`](functions/cassini/curve_gear_cassini_pair.scad) — curve_gear_cassini_pair example: One-to-one executable example for the documented public API.

> [`example_functions_circle_curve_gear_circle`](#function-example_functions_circle_curve_gear_circle): [`functions/circle/curve_gear_circle.scad`](functions/circle/curve_gear_circle.scad) — curve gear circle: Executable example for curve gear circle.

> [`example_functions_circle_curve_gear_circle_body`](#function-example_functions_circle_curve_gear_circle_body): [`functions/circle/curve_gear_circle_body.scad`](functions/circle/curve_gear_circle_body.scad) — curve gear circle body: Executable example for curve gear circle body.

> [`example_functions_circle_curve_gear_circle_mate`](#function-example_functions_circle_curve_gear_circle_mate): [`functions/circle/curve_gear_circle_mate.scad`](functions/circle/curve_gear_circle_mate.scad) — curve gear circle mate: Executable example for curve gear circle mate.

> [`example_functions_circle_curve_gear_circle_pair`](#function-example_functions_circle_curve_gear_circle_pair): [`functions/circle/curve_gear_circle_pair.scad`](functions/circle/curve_gear_circle_pair.scad) — curve gear circle pair: Executable example for curve gear circle pair.

> [`example_functions_ellipse_curve_gear_ellipse`](#function-example_functions_ellipse_curve_gear_ellipse): [`functions/ellipse/curve_gear_ellipse.scad`](functions/ellipse/curve_gear_ellipse.scad) — curve_gear_ellipse example: One-to-one executable example for the documented public API.

> [`example_functions_ellipse_curve_gear_ellipse_body`](#function-example_functions_ellipse_curve_gear_ellipse_body): [`functions/ellipse/curve_gear_ellipse_body.scad`](functions/ellipse/curve_gear_ellipse_body.scad) — curve_gear_ellipse_body example: One-to-one executable example for the documented public API.

> [`example_functions_ellipse_curve_gear_ellipse_centre_distance`](#function-example_functions_ellipse_curve_gear_ellipse_centre_distance): [`functions/ellipse/curve_gear_ellipse_centre_distance.scad`](functions/ellipse/curve_gear_ellipse_centre_distance.scad) — curve_gear_ellipse_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_ellipse_curve_gear_ellipse_mate`](#function-example_functions_ellipse_curve_gear_ellipse_mate): [`functions/ellipse/curve_gear_ellipse_mate.scad`](functions/ellipse/curve_gear_ellipse_mate.scad) — curve_gear_ellipse_mate example: One-to-one executable example for the documented public API.

> [`example_functions_ellipse_curve_gear_ellipse_mate_rotation`](#function-example_functions_ellipse_curve_gear_ellipse_mate_rotation): [`functions/ellipse/curve_gear_ellipse_mate_rotation.scad`](functions/ellipse/curve_gear_ellipse_mate_rotation.scad) — curve_gear_ellipse_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_ellipse_curve_gear_ellipse_pair`](#function-example_functions_ellipse_curve_gear_ellipse_pair): [`functions/ellipse/curve_gear_ellipse_pair.scad`](functions/ellipse/curve_gear_ellipse_pair.scad) — curve_gear_ellipse_pair example: One-to-one executable example for the documented public API.

> [`example_functions_epitrochoid_curve_gear_epitrochoid`](#function-example_functions_epitrochoid_curve_gear_epitrochoid): [`functions/epitrochoid/curve_gear_epitrochoid.scad`](functions/epitrochoid/curve_gear_epitrochoid.scad) — curve_gear_epitrochoid example: One-to-one executable example for the documented public API.

> [`example_functions_epitrochoid_curve_gear_epitrochoid_body`](#function-example_functions_epitrochoid_curve_gear_epitrochoid_body): [`functions/epitrochoid/curve_gear_epitrochoid_body.scad`](functions/epitrochoid/curve_gear_epitrochoid_body.scad) — curve_gear_epitrochoid_body example: One-to-one executable example for the documented public API.

> [`example_functions_epitrochoid_curve_gear_epitrochoid_centre_distance`](#function-example_functions_epitrochoid_curve_gear_epitrochoid_centre_distance): [`functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad`](functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad) — curve_gear_epitrochoid_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_epitrochoid_curve_gear_epitrochoid_mate`](#function-example_functions_epitrochoid_curve_gear_epitrochoid_mate): [`functions/epitrochoid/curve_gear_epitrochoid_mate.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate.scad) — curve_gear_epitrochoid_mate example: One-to-one executable example for the documented public API.

> [`example_functions_epitrochoid_curve_gear_epitrochoid_mate_rotation`](#function-example_functions_epitrochoid_curve_gear_epitrochoid_mate_rotation): [`functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad) — curve_gear_epitrochoid_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_epitrochoid_curve_gear_epitrochoid_pair`](#function-example_functions_epitrochoid_curve_gear_epitrochoid_pair): [`functions/epitrochoid/curve_gear_epitrochoid_pair.scad`](functions/epitrochoid/curve_gear_epitrochoid_pair.scad) — curve_gear_epitrochoid_pair example: One-to-one executable example for the documented public API.

> [`example_functions_fourier_curve_gear_fourier`](#function-example_functions_fourier_curve_gear_fourier): [`functions/fourier/curve_gear_fourier.scad`](functions/fourier/curve_gear_fourier.scad) — curve_gear_fourier example: One-to-one executable example for the documented public API.

> [`example_functions_fourier_curve_gear_fourier_body`](#function-example_functions_fourier_curve_gear_fourier_body): [`functions/fourier/curve_gear_fourier_body.scad`](functions/fourier/curve_gear_fourier_body.scad) — curve_gear_fourier_body example: One-to-one executable example for the documented public API.

> [`example_functions_fourier_curve_gear_fourier_centre_distance`](#function-example_functions_fourier_curve_gear_fourier_centre_distance): [`functions/fourier/curve_gear_fourier_centre_distance.scad`](functions/fourier/curve_gear_fourier_centre_distance.scad) — curve_gear_fourier_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_fourier_curve_gear_fourier_mate`](#function-example_functions_fourier_curve_gear_fourier_mate): [`functions/fourier/curve_gear_fourier_mate.scad`](functions/fourier/curve_gear_fourier_mate.scad) — curve_gear_fourier_mate example: One-to-one executable example for the documented public API.

> [`example_functions_fourier_curve_gear_fourier_mate_rotation`](#function-example_functions_fourier_curve_gear_fourier_mate_rotation): [`functions/fourier/curve_gear_fourier_mate_rotation.scad`](functions/fourier/curve_gear_fourier_mate_rotation.scad) — curve_gear_fourier_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_fourier_curve_gear_fourier_pair`](#function-example_functions_fourier_curve_gear_fourier_pair): [`functions/fourier/curve_gear_fourier_pair.scad`](functions/fourier/curve_gear_fourier_pair.scad) — curve_gear_fourier_pair example: One-to-one executable example for the documented public API.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid): [`functions/hypotrochoid/curve_gear_hypotrochoid.scad`](functions/hypotrochoid/curve_gear_hypotrochoid.scad) — curve_gear_hypotrochoid example */: Executable example for curve gear hypotrochoid.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid_body`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid_body): [`functions/hypotrochoid/curve_gear_hypotrochoid_body.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body.scad) — curve_gear_hypotrochoid_body example */: Executable example for curve gear hypotrochoid body.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid_centre_distance`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid_centre_distance): [`functions/hypotrochoid/curve_gear_hypotrochoid_centre_distance.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_centre_distance.scad) — curve_gear_hypotrochoid_centre_distance example */: Executable example for curve gear hypotrochoid centre distance.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid_mate`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid_mate): [`functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad) — curve_gear_hypotrochoid_mate example */: Executable example for curve gear hypotrochoid mate.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid_mate_rotation`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid_mate_rotation): [`functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad) — curve_gear_hypotrochoid_mate_rotation example */: Executable example for curve gear hypotrochoid mate rotation.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid_pair`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid_pair): [`functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad) — curve_gear_hypotrochoid_pair example */: Executable example for curve gear hypotrochoid pair.

> [`example_functions_hypotrochoid_curve_gear_hypotrochoid_pair_alternative`](#function-example_functions_hypotrochoid_curve_gear_hypotrochoid_pair_alternative): [`functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad) — curve_gear_hypotrochoid_pair alternative */: Executable example for curve gear hypotrochoid pair alternative.

> [`example_functions_lobed_curve_gear_lobed`](#function-example_functions_lobed_curve_gear_lobed): [`functions/lobed/curve_gear_lobed.scad`](functions/lobed/curve_gear_lobed.scad) — curve_gear_lobed example: One-to-one executable example for the documented public API.

> [`example_functions_lobed_curve_gear_lobed_body`](#function-example_functions_lobed_curve_gear_lobed_body): [`functions/lobed/curve_gear_lobed_body.scad`](functions/lobed/curve_gear_lobed_body.scad) — curve_gear_lobed_body example: One-to-one executable example for the documented public API.

> [`example_functions_lobed_curve_gear_lobed_centre_distance`](#function-example_functions_lobed_curve_gear_lobed_centre_distance): [`functions/lobed/curve_gear_lobed_centre_distance.scad`](functions/lobed/curve_gear_lobed_centre_distance.scad) — curve_gear_lobed_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_lobed_curve_gear_lobed_mate`](#function-example_functions_lobed_curve_gear_lobed_mate): [`functions/lobed/curve_gear_lobed_mate.scad`](functions/lobed/curve_gear_lobed_mate.scad) — curve_gear_lobed_mate example: One-to-one executable example for the documented public API.

> [`example_functions_lobed_curve_gear_lobed_mate_rotation`](#function-example_functions_lobed_curve_gear_lobed_mate_rotation): [`functions/lobed/curve_gear_lobed_mate_rotation.scad`](functions/lobed/curve_gear_lobed_mate_rotation.scad) — curve_gear_lobed_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_lobed_curve_gear_lobed_pair`](#function-example_functions_lobed_curve_gear_lobed_pair): [`functions/lobed/curve_gear_lobed_pair.scad`](functions/lobed/curve_gear_lobed_pair.scad) — curve_gear_lobed_pair example: One-to-one executable example for the documented public API.

> [`example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral`](#function-example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral): [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad) — curve_gear_logarithmic_spiral example: One-to-one executable example for the documented public API.

> [`example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_body`](#function-example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_body): [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad) — curve_gear_logarithmic_spiral_body example: One-to-one executable example for the documented public API.

> [`example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_mate`](#function-example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_mate): [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad) — curve_gear_logarithmic_spiral_mate example: One-to-one executable example for the documented public API.

> [`example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_pair`](#function-example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_pair): [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad) — curve_gear_logarithmic_spiral_pair example: One-to-one executable example for the documented public API.

> [`example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_reference_separation`](#function-example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_reference_separation): [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad) — curve_gear_logarithmic_spiral_reference_separation example: One-to-one executable example for the documented scalar API.

> [`example_functions_pascal_curve_gear_pascal`](#function-example_functions_pascal_curve_gear_pascal): [`functions/pascal/curve_gear_pascal.scad`](functions/pascal/curve_gear_pascal.scad) — curve_gear_pascal example: One-to-one executable example for the documented public API.

> [`example_functions_pascal_curve_gear_pascal_body`](#function-example_functions_pascal_curve_gear_pascal_body): [`functions/pascal/curve_gear_pascal_body.scad`](functions/pascal/curve_gear_pascal_body.scad) — curve_gear_pascal_body example: One-to-one executable example for the documented public API.

> [`example_functions_pascal_curve_gear_pascal_centre_distance`](#function-example_functions_pascal_curve_gear_pascal_centre_distance): [`functions/pascal/curve_gear_pascal_centre_distance.scad`](functions/pascal/curve_gear_pascal_centre_distance.scad) — curve_gear_pascal_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_pascal_curve_gear_pascal_mate`](#function-example_functions_pascal_curve_gear_pascal_mate): [`functions/pascal/curve_gear_pascal_mate.scad`](functions/pascal/curve_gear_pascal_mate.scad) — curve_gear_pascal_mate example: One-to-one executable example for the documented public API.

> [`example_functions_pascal_curve_gear_pascal_mate_rotation`](#function-example_functions_pascal_curve_gear_pascal_mate_rotation): [`functions/pascal/curve_gear_pascal_mate_rotation.scad`](functions/pascal/curve_gear_pascal_mate_rotation.scad) — curve_gear_pascal_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_pascal_curve_gear_pascal_pair`](#function-example_functions_pascal_curve_gear_pascal_pair): [`functions/pascal/curve_gear_pascal_pair.scad`](functions/pascal/curve_gear_pascal_pair.scad) — curve_gear_pascal_pair example: One-to-one executable example for the documented public API.

> [`example_functions_superformula_curve_gear_superformula`](#function-example_functions_superformula_curve_gear_superformula): [`functions/superformula/curve_gear_superformula.scad`](functions/superformula/curve_gear_superformula.scad) — curve_gear_superformula example: One-to-one executable example for the documented public API.

> [`example_functions_superformula_curve_gear_superformula_body`](#function-example_functions_superformula_curve_gear_superformula_body): [`functions/superformula/curve_gear_superformula_body.scad`](functions/superformula/curve_gear_superformula_body.scad) — curve_gear_superformula_body example: One-to-one executable example for the documented public API.

> [`example_functions_superformula_curve_gear_superformula_centre_distance`](#function-example_functions_superformula_curve_gear_superformula_centre_distance): [`functions/superformula/curve_gear_superformula_centre_distance.scad`](functions/superformula/curve_gear_superformula_centre_distance.scad) — curve_gear_superformula_centre_distance example: One-to-one executable example for the documented scalar API.

> [`example_functions_superformula_curve_gear_superformula_mate`](#function-example_functions_superformula_curve_gear_superformula_mate): [`functions/superformula/curve_gear_superformula_mate.scad`](functions/superformula/curve_gear_superformula_mate.scad) — curve_gear_superformula_mate example: One-to-one executable example for the documented public API.

> [`example_functions_superformula_curve_gear_superformula_mate_rotation`](#function-example_functions_superformula_curve_gear_superformula_mate_rotation): [`functions/superformula/curve_gear_superformula_mate_rotation.scad`](functions/superformula/curve_gear_superformula_mate_rotation.scad) — curve_gear_superformula_mate_rotation example: One-to-one executable example for the documented scalar API.

> [`example_functions_superformula_curve_gear_superformula_pair`](#function-example_functions_superformula_curve_gear_superformula_pair): [`functions/superformula/curve_gear_superformula_pair.scad`](functions/superformula/curve_gear_superformula_pair.scad) — curve_gear_superformula_pair example: One-to-one executable example for the documented public API.

> [`example_tooth_construction`](#function-example_tooth_construction): [`tooth/construction.scad`](tooth/construction.scad) — Tooth construction preview: Render one validated cached local tooth candidate.

> [`example_tooth_placement`](#function-example_tooth_placement): [`tooth/placement.scad`](tooth/placement.scad) — Tooth placement preview: Render cached teeth placed along a sinusoidal edge of a body.

> [`example_tooth_assembly`](#function-example_tooth_assembly): [`tooth/assembly.scad`](tooth/assembly.scad) — Tooth assembly preview: Compare placed tooth boundaries with the final assembled outline.


## Functions

The module `Executable examples` defines the following functions.

### Function `example_functions_bezier_curve_gear_bezier`


![curve_gear_bezier example preview](../images/functions/bezier/curve_gear_bezier.png)

[`functions/bezier/curve_gear_bezier.scad`](functions/bezier/curve_gear_bezier.scad) — curve_gear_bezier example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_bezier_curve_gear_bezier_alternative`


![Bézier asymmetric alternative preview](../images/functions/bezier/curve_gear_bezier_alternative.png)

[`functions/bezier/curve_gear_bezier_alternative.scad`](functions/bezier/curve_gear_bezier_alternative.scad) — Bézier asymmetric alternative: A visibly non-circular but radially admissible Bézier pitch curve.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_bezier_curve_gear_bezier_body`


![curve_gear_bezier_body example preview](../images/functions/bezier/curve_gear_bezier_body.png)

[`functions/bezier/curve_gear_bezier_body.scad`](functions/bezier/curve_gear_bezier_body.scad) — curve_gear_bezier_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_bezier_curve_gear_bezier_mate`


![curve_gear_bezier_mate example preview](../images/functions/bezier/curve_gear_bezier_mate.png)

[`functions/bezier/curve_gear_bezier_mate.scad`](functions/bezier/curve_gear_bezier_mate.scad) — curve_gear_bezier_mate example: One-to-one executable example for the admissible Bézier mate API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_bezier_curve_gear_bezier_pair`


![curve_gear_bezier_pair example preview](../images/functions/bezier/curve_gear_bezier_pair.png)

[`functions/bezier/curve_gear_bezier_pair.scad`](functions/bezier/curve_gear_bezier_pair.scad) — curve_gear_bezier_pair example: One-to-one executable example for the Bézier pair API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_bezier_curve_gear_bezier_pair_alternative`


![Bézier asymmetric pair alternative preview](../images/functions/bezier/curve_gear_bezier_pair_alternative.png)

[`functions/bezier/curve_gear_bezier_pair_alternative.scad`](functions/bezier/curve_gear_bezier_pair_alternative.scad) — Bézier asymmetric pair alternative: The same visibly non-circular Bézier curve and its derived mate.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_cassini_curve_gear_cassini`


![curve_gear_cassini example preview](../images/functions/cassini/curve_gear_cassini.png)

[`functions/cassini/curve_gear_cassini.scad`](functions/cassini/curve_gear_cassini.scad) — curve_gear_cassini example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_cassini_curve_gear_cassini_body`


![curve_gear_cassini_body example preview](../images/functions/cassini/curve_gear_cassini_body.png)

[`functions/cassini/curve_gear_cassini_body.scad`](functions/cassini/curve_gear_cassini_body.scad) — curve_gear_cassini_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_cassini_curve_gear_cassini_centre_distance`


[`functions/cassini/curve_gear_cassini_centre_distance.scad`](functions/cassini/curve_gear_cassini_centre_distance.scad) — curve_gear_cassini_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_cassini_curve_gear_cassini_mate`


![curve_gear_cassini_mate example preview](../images/functions/cassini/curve_gear_cassini_mate.png)

[`functions/cassini/curve_gear_cassini_mate.scad`](functions/cassini/curve_gear_cassini_mate.scad) — curve_gear_cassini_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_cassini_curve_gear_cassini_mate_rotation`


[`functions/cassini/curve_gear_cassini_mate_rotation.scad`](functions/cassini/curve_gear_cassini_mate_rotation.scad) — curve_gear_cassini_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_cassini_curve_gear_cassini_pair`


![curve_gear_cassini_pair example preview](../images/functions/cassini/curve_gear_cassini_pair.png)

[`functions/cassini/curve_gear_cassini_pair.scad`](functions/cassini/curve_gear_cassini_pair.scad) — curve_gear_cassini_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_circle_curve_gear_circle`


![curve gear circle preview](../images/functions/circle/curve_gear_circle.png)

[`functions/circle/curve_gear_circle.scad`](functions/circle/curve_gear_circle.scad) — curve gear circle: Executable example for curve gear circle.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_circle_curve_gear_circle_body`


![curve gear circle body preview](../images/functions/circle/curve_gear_circle_body.png)

[`functions/circle/curve_gear_circle_body.scad`](functions/circle/curve_gear_circle_body.scad) — curve gear circle body: Executable example for curve gear circle body.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_circle_curve_gear_circle_mate`


![curve gear circle mate preview](../images/functions/circle/curve_gear_circle_mate.png)

[`functions/circle/curve_gear_circle_mate.scad`](functions/circle/curve_gear_circle_mate.scad) — curve gear circle mate: Executable example for curve gear circle mate.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_circle_curve_gear_circle_pair`


![curve gear circle pair preview](../images/functions/circle/curve_gear_circle_pair.png)

[`functions/circle/curve_gear_circle_pair.scad`](functions/circle/curve_gear_circle_pair.scad) — curve gear circle pair: Executable example for curve gear circle pair.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_ellipse_curve_gear_ellipse`


![curve_gear_ellipse example preview](../images/functions/ellipse/curve_gear_ellipse.png)

[`functions/ellipse/curve_gear_ellipse.scad`](functions/ellipse/curve_gear_ellipse.scad) — curve_gear_ellipse example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_ellipse_curve_gear_ellipse_body`


![curve_gear_ellipse_body example preview](../images/functions/ellipse/curve_gear_ellipse_body.png)

[`functions/ellipse/curve_gear_ellipse_body.scad`](functions/ellipse/curve_gear_ellipse_body.scad) — curve_gear_ellipse_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_ellipse_curve_gear_ellipse_centre_distance`


[`functions/ellipse/curve_gear_ellipse_centre_distance.scad`](functions/ellipse/curve_gear_ellipse_centre_distance.scad) — curve_gear_ellipse_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_ellipse_curve_gear_ellipse_mate`


![curve_gear_ellipse_mate example preview](../images/functions/ellipse/curve_gear_ellipse_mate.png)

[`functions/ellipse/curve_gear_ellipse_mate.scad`](functions/ellipse/curve_gear_ellipse_mate.scad) — curve_gear_ellipse_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_ellipse_curve_gear_ellipse_mate_rotation`


[`functions/ellipse/curve_gear_ellipse_mate_rotation.scad`](functions/ellipse/curve_gear_ellipse_mate_rotation.scad) — curve_gear_ellipse_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_ellipse_curve_gear_ellipse_pair`


![curve_gear_ellipse_pair example preview](../images/functions/ellipse/curve_gear_ellipse_pair.png)

[`functions/ellipse/curve_gear_ellipse_pair.scad`](functions/ellipse/curve_gear_ellipse_pair.scad) — curve_gear_ellipse_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_epitrochoid_curve_gear_epitrochoid`


![curve_gear_epitrochoid example preview](../images/functions/epitrochoid/curve_gear_epitrochoid.png)

[`functions/epitrochoid/curve_gear_epitrochoid.scad`](functions/epitrochoid/curve_gear_epitrochoid.scad) — curve_gear_epitrochoid example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_epitrochoid_curve_gear_epitrochoid_body`


![curve_gear_epitrochoid_body example preview](../images/functions/epitrochoid/curve_gear_epitrochoid_body.png)

[`functions/epitrochoid/curve_gear_epitrochoid_body.scad`](functions/epitrochoid/curve_gear_epitrochoid_body.scad) — curve_gear_epitrochoid_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_epitrochoid_curve_gear_epitrochoid_centre_distance`


[`functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad`](functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad) — curve_gear_epitrochoid_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_epitrochoid_curve_gear_epitrochoid_mate`


![curve_gear_epitrochoid_mate example preview](../images/functions/epitrochoid/curve_gear_epitrochoid_mate.png)

[`functions/epitrochoid/curve_gear_epitrochoid_mate.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate.scad) — curve_gear_epitrochoid_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_epitrochoid_curve_gear_epitrochoid_mate_rotation`


[`functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad) — curve_gear_epitrochoid_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_epitrochoid_curve_gear_epitrochoid_pair`


![curve_gear_epitrochoid_pair example preview](../images/functions/epitrochoid/curve_gear_epitrochoid_pair.png)

[`functions/epitrochoid/curve_gear_epitrochoid_pair.scad`](functions/epitrochoid/curve_gear_epitrochoid_pair.scad) — curve_gear_epitrochoid_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_fourier_curve_gear_fourier`


![curve_gear_fourier example preview](../images/functions/fourier/curve_gear_fourier.png)

[`functions/fourier/curve_gear_fourier.scad`](functions/fourier/curve_gear_fourier.scad) — curve_gear_fourier example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_fourier_curve_gear_fourier_body`


![curve_gear_fourier_body example preview](../images/functions/fourier/curve_gear_fourier_body.png)

[`functions/fourier/curve_gear_fourier_body.scad`](functions/fourier/curve_gear_fourier_body.scad) — curve_gear_fourier_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_fourier_curve_gear_fourier_centre_distance`


[`functions/fourier/curve_gear_fourier_centre_distance.scad`](functions/fourier/curve_gear_fourier_centre_distance.scad) — curve_gear_fourier_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_fourier_curve_gear_fourier_mate`


![curve_gear_fourier_mate example preview](../images/functions/fourier/curve_gear_fourier_mate.png)

[`functions/fourier/curve_gear_fourier_mate.scad`](functions/fourier/curve_gear_fourier_mate.scad) — curve_gear_fourier_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_fourier_curve_gear_fourier_mate_rotation`


[`functions/fourier/curve_gear_fourier_mate_rotation.scad`](functions/fourier/curve_gear_fourier_mate_rotation.scad) — curve_gear_fourier_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_fourier_curve_gear_fourier_pair`


![curve_gear_fourier_pair example preview](../images/functions/fourier/curve_gear_fourier_pair.png)

[`functions/fourier/curve_gear_fourier_pair.scad`](functions/fourier/curve_gear_fourier_pair.scad) — curve_gear_fourier_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid`


![curve_gear_hypotrochoid example */ preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid.png)

[`functions/hypotrochoid/curve_gear_hypotrochoid.scad`](functions/hypotrochoid/curve_gear_hypotrochoid.scad) — curve_gear_hypotrochoid example */: Executable example for curve gear hypotrochoid.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid_body`


![curve_gear_hypotrochoid_body example */ preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png)

[`functions/hypotrochoid/curve_gear_hypotrochoid_body.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body.scad) — curve_gear_hypotrochoid_body example */: Executable example for curve gear hypotrochoid body.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid_centre_distance`


[`functions/hypotrochoid/curve_gear_hypotrochoid_centre_distance.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_centre_distance.scad) — curve_gear_hypotrochoid_centre_distance example */: Executable example for curve gear hypotrochoid centre distance.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid_mate`


![curve_gear_hypotrochoid_mate example */ preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_mate.png)

[`functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad) — curve_gear_hypotrochoid_mate example */: Executable example for curve gear hypotrochoid mate.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid_mate_rotation`


[`functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad) — curve_gear_hypotrochoid_mate_rotation example */: Executable example for curve gear hypotrochoid mate rotation.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid_pair`


![curve_gear_hypotrochoid_pair example */ preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair.png)

[`functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad) — curve_gear_hypotrochoid_pair example */: Executable example for curve gear hypotrochoid pair.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_hypotrochoid_curve_gear_hypotrochoid_pair_alternative`


![curve_gear_hypotrochoid_pair alternative */ preview](../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.png)

[`functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad) — curve_gear_hypotrochoid_pair alternative */: Executable example for curve gear hypotrochoid pair alternative.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_lobed_curve_gear_lobed`


![curve_gear_lobed example preview](../images/functions/lobed/curve_gear_lobed.png)

[`functions/lobed/curve_gear_lobed.scad`](functions/lobed/curve_gear_lobed.scad) — curve_gear_lobed example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_lobed_curve_gear_lobed_body`


![curve_gear_lobed_body example preview](../images/functions/lobed/curve_gear_lobed_body.png)

[`functions/lobed/curve_gear_lobed_body.scad`](functions/lobed/curve_gear_lobed_body.scad) — curve_gear_lobed_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_lobed_curve_gear_lobed_centre_distance`


[`functions/lobed/curve_gear_lobed_centre_distance.scad`](functions/lobed/curve_gear_lobed_centre_distance.scad) — curve_gear_lobed_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_lobed_curve_gear_lobed_mate`


![curve_gear_lobed_mate example preview](../images/functions/lobed/curve_gear_lobed_mate.png)

[`functions/lobed/curve_gear_lobed_mate.scad`](functions/lobed/curve_gear_lobed_mate.scad) — curve_gear_lobed_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_lobed_curve_gear_lobed_mate_rotation`


[`functions/lobed/curve_gear_lobed_mate_rotation.scad`](functions/lobed/curve_gear_lobed_mate_rotation.scad) — curve_gear_lobed_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_lobed_curve_gear_lobed_pair`


![curve_gear_lobed_pair example preview](../images/functions/lobed/curve_gear_lobed_pair.png)

[`functions/lobed/curve_gear_lobed_pair.scad`](functions/lobed/curve_gear_lobed_pair.scad) — curve_gear_lobed_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral`


![curve_gear_logarithmic_spiral example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png)

[`functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad) — curve_gear_logarithmic_spiral example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_body`


![curve_gear_logarithmic_spiral_body example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png)

[`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad) — curve_gear_logarithmic_spiral_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_mate`


![curve_gear_logarithmic_spiral_mate example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.png)

[`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad) — curve_gear_logarithmic_spiral_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_pair`


![curve_gear_logarithmic_spiral_pair example preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.png)

[`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad) — curve_gear_logarithmic_spiral_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_logarithmic_spiral_curve_gear_logarithmic_spiral_reference_separation`


[`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad) — curve_gear_logarithmic_spiral_reference_separation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_pascal_curve_gear_pascal`


![curve_gear_pascal example preview](../images/functions/pascal/curve_gear_pascal.png)

[`functions/pascal/curve_gear_pascal.scad`](functions/pascal/curve_gear_pascal.scad) — curve_gear_pascal example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_pascal_curve_gear_pascal_body`


![curve_gear_pascal_body example preview](../images/functions/pascal/curve_gear_pascal_body.png)

[`functions/pascal/curve_gear_pascal_body.scad`](functions/pascal/curve_gear_pascal_body.scad) — curve_gear_pascal_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_pascal_curve_gear_pascal_centre_distance`


[`functions/pascal/curve_gear_pascal_centre_distance.scad`](functions/pascal/curve_gear_pascal_centre_distance.scad) — curve_gear_pascal_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_pascal_curve_gear_pascal_mate`


![curve_gear_pascal_mate example preview](../images/functions/pascal/curve_gear_pascal_mate.png)

[`functions/pascal/curve_gear_pascal_mate.scad`](functions/pascal/curve_gear_pascal_mate.scad) — curve_gear_pascal_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_pascal_curve_gear_pascal_mate_rotation`


[`functions/pascal/curve_gear_pascal_mate_rotation.scad`](functions/pascal/curve_gear_pascal_mate_rotation.scad) — curve_gear_pascal_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_pascal_curve_gear_pascal_pair`


![curve_gear_pascal_pair example preview](../images/functions/pascal/curve_gear_pascal_pair.png)

[`functions/pascal/curve_gear_pascal_pair.scad`](functions/pascal/curve_gear_pascal_pair.scad) — curve_gear_pascal_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_superformula_curve_gear_superformula`


![curve_gear_superformula example preview](../images/functions/superformula/curve_gear_superformula.png)

[`functions/superformula/curve_gear_superformula.scad`](functions/superformula/curve_gear_superformula.scad) — curve_gear_superformula example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_superformula_curve_gear_superformula_body`


![curve_gear_superformula_body example preview](../images/functions/superformula/curve_gear_superformula_body.png)

[`functions/superformula/curve_gear_superformula_body.scad`](functions/superformula/curve_gear_superformula_body.scad) — curve_gear_superformula_body example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_superformula_curve_gear_superformula_centre_distance`


[`functions/superformula/curve_gear_superformula_centre_distance.scad`](functions/superformula/curve_gear_superformula_centre_distance.scad) — curve_gear_superformula_centre_distance example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_superformula_curve_gear_superformula_mate`


![curve_gear_superformula_mate example preview](../images/functions/superformula/curve_gear_superformula_mate.png)

[`functions/superformula/curve_gear_superformula_mate.scad`](functions/superformula/curve_gear_superformula_mate.scad) — curve_gear_superformula_mate example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_superformula_curve_gear_superformula_mate_rotation`


[`functions/superformula/curve_gear_superformula_mate_rotation.scad`](functions/superformula/curve_gear_superformula_mate_rotation.scad) — curve_gear_superformula_mate_rotation example: One-to-one executable example for the documented scalar API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_functions_superformula_curve_gear_superformula_pair`


![curve_gear_superformula_pair example preview](../images/functions/superformula/curve_gear_superformula_pair.png)

[`functions/superformula/curve_gear_superformula_pair.scad`](functions/superformula/curve_gear_superformula_pair.scad) — curve_gear_superformula_pair example: One-to-one executable example for the documented public API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_tooth_construction`


![Tooth construction preview preview](../images/tooth/construction.png)

[`tooth/construction.scad`](tooth/construction.scad) — Tooth construction preview: Render one validated cached local tooth candidate.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_tooth_placement`


![Tooth placement preview preview](../images/tooth/placement.png)

[`tooth/placement.scad`](tooth/placement.scad) — Tooth placement preview: Render cached teeth placed along a sinusoidal edge of a body.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).

### Function `example_tooth_assembly`


![Tooth assembly preview preview](../images/tooth/assembly.png)

[`tooth/assembly.scad`](tooth/assembly.scad) — Tooth assembly preview: Compare placed tooth boundaries with the final assembled outline.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-executable-examples).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
