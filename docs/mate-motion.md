# Mate motion

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md) · [Fourier](fourier.md)
  - [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Pascal](pascal.md) · [Superformula](superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Mate motion`


Family files own radius and pitch-point equations. This file owns the
shared midpoint integration, closure solve, direct mate-point construction
and phase interpretation used by every dynamically conjugate family.

The fixed-centre conjugate pitch relation is `r2=D-r1` with rolling law
`dphi/dtheta=r1/(D-r1)`. Shape-driven families provide `r1(theta)` or an
adapted closed pitch curve; a future motion-driven adapter may instead
derive both radii from a displacement law before entering this same core.
These equations define pitch geometry, not exact tooth-flank geometry.

### Brief content:

**Functions**:

> [`_cg_motion_values_from_mid_radii(mid_radii, D)`](#function-_cg_motion_values_from_mid_radiimid_radii-d): Integrate one revolution from midpoint radii at a candidate centre distance.

> [`_cg_motion_integration_state`](#function-_cg_motion_integration_state): Build the shared incremental values, cumulative angles and motion table once.

> [`_cg_motion_table_from_mid_radii(mid_radii, D)`](#function-_cg_motion_table_from_mid_radiimid_radii-d): Build a phase-to-phase motion table from midpoint radii.

> [`_cg_motion_closure_error_from_mid_radii(mid_radii, D)`](#function-_cg_motion_closure_error_from_mid_radiimid_radii-d): Return the one-turn closure error for midpoint-radius integration.

> [`_cg_motion_table_from_radius_samples`](#function-_cg_motion_table_from_radius_samples): Integrate the rolling law at driver-angle samples.

> [`_cg_solve_mate_distance(mid_radii, lo, hi)`](#function-_cg_solve_mate_distancemid_radii-lo-hi): Solve the centre distance whose integrated mate motion closes after one turn.

> [`_cg_mate_points_from_radius_samples`](#function-_cg_mate_points_from_radius_samples): Construct mate pitch points directly while advancing driver angle.

> [`_cg_mate_points_from_radius_samples_with_state`](#function-_cg_mate_points_from_radius_samples_with_state): Construct mate points from a previously integrated motion state.

> [`_cg_mate_point_from_radius(radius, D, phi)`](#function-_cg_mate_point_from_radiusradius-d-phi): Map a driver phase and evaluated driver radius to its opposed mate pitch point.

> [`_cg_motion_y_unwrapped(tab, angle)`](#function-_cg_motion_y_unwrappedtab-angle): Return the continuous mate angle for a driver angle from a motion table.

> [`_cg_mate_rotation_for_phase(tab, phase)`](#function-_cg_mate_rotation_for_phasetab-phase): Convert a motion-table phase into the mate display rotation.

> [`_cg_motion_closure_error`](#function-_cg_motion_closure_error): Return the final accumulated mate-angle error in degrees.


## Functions

The module `Mate motion` defines the following functions.

### Function `_cg_motion_values_from_mid_radii(mid_radii, D)`


Integrate one revolution from midpoint radii at a candidate centre distance.

**Parameters:**

- `mid_radii`: {array} Driver radii sampled at integration midpoints.
- `D`: {number > 0} Candidate centre distance in mm.

**Returns:**

- `{array}`: Incremental mate-angle values in degrees.

Back to [module description](#module-mate-motion).

### Function `_cg_motion_integration_state`


Build the shared incremental values, cumulative angles and motion table once.

**Parameters:**

- `driver_radii`: {array of number} Driver radii at output angles, or `undef`.
- `mid_radii`: {array of number} Driver radii at interval midpoints.
- `D`: {number > 0} Centre distance in mm.

**Returns:**

- `{array}`: `[values, cumulative, motion]` integration state.

Back to [module description](#module-mate-motion).

### Function `_cg_motion_table_from_mid_radii(mid_radii, D)`


Build a phase-to-phase motion table from midpoint radii.

**Parameters:**

- `mid_radii`: {array} Driver radii sampled at integration midpoints.
- `D`: {number > 0} Centre distance in mm.

**Returns:**

- `{array}`: Table of `[driver phase, mate phase]` pairs in degrees.

Back to [module description](#module-mate-motion).

### Function `_cg_motion_closure_error_from_mid_radii(mid_radii, D)`


Return the one-turn closure error for midpoint-radius integration.

**Parameters:**

- `mid_radii`: {array} Driver radii sampled at integration midpoints.
- `D`: {number > 0} Candidate centre distance in mm.

**Returns:**

- `{number}`: Closure error in degrees.

Back to [module description](#module-mate-motion).

### Function `_cg_motion_table_from_radius_samples`



The midpoint radii are used only for integration.  The table is therefore
an output of the direct driver-angle integration, not an inverse-motion
reconstruction of the mate.

**Parameters:**

- `driver_radii`: {array of number} Driver radii at output angles.
- `mid_radii`: {array of number} Driver radii at interval midpoints.
- `D`: {number > 0} Centre distance in mm.

**Returns:**

- `{array}`: Table of `[driver phase, mate phase]` pairs in degrees.

Back to [module description](#module-mate-motion).

### Function `_cg_solve_mate_distance(mid_radii, lo, hi)`


Solve the centre distance whose integrated mate motion closes after one turn.

**Parameters:**

- `mid_radii`: {array} Driver radii sampled at integration midpoints.
- `lo`: {number > 0} Lower centre-distance bracket in mm.
- `hi`: {number > 0} Upper centre-distance bracket in mm.
- `i`: {integer, default 0} Recursive bisection iteration.

**Returns:**

- `{number}`: Solved centre distance in mm.

Back to [module description](#module-mate-motion).

### Function `_cg_mate_points_from_radius_samples`



For each driver sample `theta_i`, the accumulated rolling angle `phi_i`
is evaluated first and the mate radius is then `D-driver_radii[i]`.
This is the primary mate-construction path for all radial families.

**Parameters:**

- `driver_radii`: {array of number} Driver radii at output angles.
- `mid_radii`: {array of number} Driver radii at interval midpoints.
- `D`: {number > 0} Centre distance in mm.

**Returns:**

- `{array of points}`: Directly generated Cartesian mate pitch points.

Back to [module description](#module-mate-motion).

### Function `_cg_mate_points_from_radius_samples_with_state`


Construct mate points from a previously integrated motion state.

**Parameters:**

- `driver_radii`: {array of number} Driver radii at output angles.
- `D`: {number > 0} Centre distance in mm.
- `integration_state`: {array} State returned by `_cg_motion_integration_state`.

**Returns:**

- `{array of points}`: Directly generated Cartesian mate pitch points.

Back to [module description](#module-mate-motion).

### Function `_cg_mate_point_from_radius(radius, D, phi)`


Map a driver phase and evaluated driver radius to its opposed mate pitch point.

**Parameters:**

- `radius`: {number > 0} Driver radius in mm.
- `D`: {number > 0} Centre distance in mm.
- `phi`: {angle} Mate polar angle in degrees.

**Returns:**

- `{array}`: Mate Cartesian pitch point in mm.

Back to [module description](#module-mate-motion).

### Function `_cg_motion_y_unwrapped(tab, angle)`


Return the continuous mate angle for a driver angle from a motion table.

**Parameters:**

- `tab`: {array} Table of `[driver phase, mate phase]` pairs.
- `angle`: {angle} Driver phase in degrees.

**Returns:**

- `{angle}`: Continuous mate phase in degrees.

Back to [module description](#module-mate-motion).

### Function `_cg_mate_rotation_for_phase(tab, phase)`


Convert a motion-table phase into the mate display rotation.

**Parameters:**

- `tab`: {array} Table of `[driver phase, mate phase]` pairs.
- `phase`: {angle} Driver phase in degrees.

**Returns:**

- `{angle}`: Mate display rotation in degrees.

Back to [module description](#module-mate-motion).

### Function `_cg_motion_closure_error`


Return the final accumulated mate-angle error in degrees.

**Parameters:**

- `motion`: {motion table} Shared driver-to-mate motion table.

**Returns:**

- `{number}`: Difference between the final mate angle and one turn.

Back to [module description](#module-mate-motion).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
