# Trochoid common

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cosine Quintic](cosine_quintic.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Logistic Dwell](logistic_dwell.md) · [Pascal](pascal.md) · [Superformula](superformula.md) · [Tanh Triad](tanh_triad.md) · [Temple Fay](temple_fay.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate preparation](mate-preparation.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)
  - [Harmonic common](harmonic-common.md) · [Trochoid common](trochoid-common.md) · [Saturating common](saturating-common.md)


## Module `Trochoid common`


This file is an implementation detail. Public family APIs live in
`epitrochoid/` and `hypotrochoid/`; the rolling equations remain in those
family modules. This layer contains only the shared curve post-processing.

### Brief content:

**Functions**:

> [`_cg_trochoid_curve_radius_from_point`](#function-_cg_trochoid_curve_radius_from_point): Evaluate the radial distance of a scaled curve point.

> [`_cg_trochoid_points_scaled_from_points`](#function-_cg_trochoid_points_scaled_from_points): Scale sampled unit-curve points.

> [`_cg_trochoid_polar_radii`](#function-_cg_trochoid_polar_radii): Sample the emitted driver polygon at uniformly spaced physical polar angles.

> [`_cg_trochoid_polar_table`](#function-_cg_trochoid_polar_table): Index a finite star-shaped driver polygon by monotonically increasing physical polar angle.

> [`_cg_trochoid_radius_at_polar_angle`](#function-_cg_trochoid_radius_at_polar_angle): Intersect a physical polar ray with the indexed polygon segment, without interpolating curve parameters.

> [`_cg_trochoid_radius_from_point`](#function-_cg_trochoid_radius_from_point): Evaluate the radial distance of a unit-curve point.

> [`_cg_trochoid_scale_from_points`](#function-_cg_trochoid_scale_from_points): Scale a sampled unit curve to the requested tooth pitch.

> [`_cg_trochoid_shape`](#function-_cg_trochoid_shape): Bind a sampled trochoid polygon to the shared physical-angle shape contract.


## Functions

The module `Trochoid common` defines the following functions.

### Function `_cg_trochoid_curve_radius_from_point`


Evaluate the radial distance of a scaled curve point.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_points_scaled_from_points`


Scale sampled unit-curve points.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_polar_radii`


Sample the emitted driver polygon at uniformly spaced physical polar angles.

**Parameters:**

- `points`: {array of 2D points} Closed star-shaped driver polygon.
- `n`: {integer >= 3} Number of motion intervals.
- `midpoint`: {boolean, default false} Use integration midpoints instead of phase boundaries.

**Returns:**

- `{array of number}`: Physical pitch radii in increasing angular order.

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_polar_table`


Index a finite star-shaped driver polygon by monotonically increasing physical polar angle.

**Parameters:**

- `points`: {array of 2D points} Closed polygon starting on the positive X ray.

**Returns:**

- `{array}`: Angle/point rows with an explicit closing row at 360 degrees.

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_radius_at_polar_angle`


Intersect a physical polar ray with the indexed polygon segment, without interpolating curve parameters.

**Parameters:**

- `table`: {array} Validated angle/point table.
- `theta`: {angle} Physical polar angle in degrees.

**Returns:**

- `{number}`: Radius of the exact sampled driver polygon at that angle.

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_radius_from_point`


Evaluate the radial distance of a unit-curve point.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_scale_from_points`


Scale a sampled unit curve to the requested tooth pitch.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-trochoid-common).

### Function `_cg_trochoid_shape`


Bind a sampled trochoid polygon to the shared physical-angle shape contract.

**Parameters:**

- `unit_points`: {array of 2D points} Unit-scale driver polygon.
- `scale`: {number > 0} Perimeter-derived physical scale.
- `lower`: {number} Solver lower bound.
- `upper`: {number} Solver upper bound.
- `radial_root`: {boolean, default false} Use radial-root tooth placement.

**Returns:**

- `{array}`: `[driver points, physical radius function, lower, upper, radial_root]`.

Back to [module description](#module-trochoid-common).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
