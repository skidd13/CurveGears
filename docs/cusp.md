# Cusp

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Cusp](cusp.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md)
  - [Fourier](fourier.md) · [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Pascal](pascal.md) · [Superformula](superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Cusp`

Three-cusp deltoid pitch geometry and conjugate motion equations.

### Brief content:


Back to [top](#).

## Module `Cusp`

Build the three-cusp deltoid gear and its radial-root body.

### Brief content:

**Functions**:

> [`curve_gear_cusp(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cuspmodul-tooth_number-width-bore-): Build the three-cusp deltoid gear with regular radial teeth at its cusps.

> [`curve_gear_cusp_body(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cusp_bodymodul-tooth_number-width-bore-): Build the three-cusp deltoid body with its integrated cusp-tip teeth.


## Functions

The module `Cusp` defines the following functions.

### Function `curve_gear_cusp(modul, tooth_number, width, bore, ...)`


![Cusp gear preview](../images/functions/cusp/curve_gear_cusp.png)

The common candidate validator accepts the full regular radial-root profile. Each cusp tooth is translated inward until its root width meets the local cusp-branch width; the cusp interval is then cropped and replaced by that unchanged tooth profile.
The mate is derived from the full placed driver outline and closed motion table.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Tooth count; one radial tooth is centred on each cusp.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Standard-flank pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 720, divisible by 3, default 720} Deltoid pitch-curve sampling density for validated cusp teeth.
- `orientation`: {angle, default 0} Whole-gear display rotation in degrees.

**Returns:**

No return

Back to [module description](#module-cusp).

### Function `curve_gear_cusp_body(modul, tooth_number, width, bore, ...)`


![Cusp gear body preview](../images/functions/cusp/curve_gear_cusp_body.png)

Build the three-cusp deltoid body with its integrated cusp-tip teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Tooth count scale.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch-curve sampling density for validated cusp geometry.
- `orientation`: {angle, default 0} Whole-body display rotation.

**Returns:**

No return

Back to [module description](#module-cusp).


Back to [top](#).

## Module `Cusp mate`

Construct the swept-envelope mate for the deltoid driver.

### Brief content:

**Functions**:

> [`curve_gear_cusp_mate(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cusp_matemodul-tooth_number-width-bore-): Build the standalone swept-envelope mate for a cusp gear.

> [`curve_gear_cusp_centre_distance(modul, tooth_number, samples=720)`](#function-curve_gear_cusp_centre_distancemodul-tooth_number-samples720): Return the solved pitch-curve centre distance for a cusp pair.

> [`curve_gear_cusp_mate_rotation(modul, tooth_number, samples=720, phase=0)`](#function-curve_gear_cusp_mate_rotationmodul-tooth_number-samples720-phase0): Return the integrated mate angle at one driver phase.


## Functions

The module `Cusp mate` defines the following functions.

### Function `curve_gear_cusp_mate(modul, tooth_number, width, bore, ...)`


![Cusp gear mate preview](../images/functions/cusp/curve_gear_cusp_mate.png)

Build the standalone swept-envelope mate for a cusp gear.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Tooth pressure angle.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `samples`: {integer >= 720, divisible by 3, default 720} Motion and pitch-curve sampling density for the validated cusp outline.
- `sweep_steps`: {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
- `max_pose_step`: {number > 0, default 0.5} Maximum angular step of either member in degrees.
- `sweep_clearance`: {number > 0, default 0.08} Envelope cutter clearance as a module fraction.
- `phase`: {angle, default 0} Driver phase used to orient the displayed mate.

**Returns:**

No return

Back to [module description](#module-cusp-mate).

### Function `curve_gear_cusp_centre_distance(modul, tooth_number, samples=720)`


Return the solved pitch-curve centre distance for a cusp pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `samples`: {integer >= 120, divisible by 3, default 720} Motion sampling density.

**Returns:**

- `{number}`: Fixed centre distance in mm.

Back to [module description](#module-cusp-mate).

### Function `curve_gear_cusp_mate_rotation(modul, tooth_number, samples=720, phase=0)`


Return the integrated mate angle at one driver phase.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `samples`: {integer >= 120, divisible by 3, default 720} Motion sampling density.
- `phase`: {angle, default 0} Driver angle in degrees.

**Returns:**

- `{angle}`: Mate display rotation in degrees.

Back to [module description](#module-cusp-mate).


Back to [top](#).

## Module `Cusp pair`

The mate's cavities are generated from the driver's complete placed outline and closed motion table.

### Brief content:

**Functions**:

> [`curve_gear_cusp_pair(modul, tooth_number, width, bore, ...)`](#function-curve_gear_cusp_pairmodul-tooth_number-width-bore-): Build a meshed or separated deltoid cusp gear pair with a swept-envelope mate.


## Functions

The module `Cusp pair` defines the following functions.

### Function `curve_gear_cusp_pair(modul, tooth_number, width, bore, ...)`


![Cusp pair preview](../images/functions/cusp/curve_gear_cusp_pair.png)

Build a meshed or separated deltoid cusp gear pair with a swept-envelope mate.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3, divisible by 3} Shared tooth count.
- `width`: {number > 0} Gear extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `pressure_angle`: {0 < angle < 90, default 20} Tooth pressure angle.
- `samples`: {integer >= 720, divisible by 3, default 720} Pitch and motion sampling density for the validated swept mate.
- `phase`: {angle, default 0} Driver motion phase.
- `together_built`: {boolean, default true} Place gears at the solved pitch distance when true.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction.
- `clearance`: {undef or >= 0} Additional radial root clearance.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate colour.
- `sweep_steps`: {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
- `max_pose_step`: {number > 0, default 0.5} Maximum angular step of either member in degrees.
- `sweep_clearance`: {number > 0, default 0.08} Envelope cutter clearance as a module fraction.

**Returns:**

No return

Back to [module description](#module-cusp-pair).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
