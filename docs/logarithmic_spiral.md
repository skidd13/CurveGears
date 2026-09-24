# Logarithmic Spiral

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](bezier.md) · [Cassini](cassini.md) · [Circle](circle.md) · [Ellipse](ellipse.md) · [Epitrochoid](epitrochoid.md) · [Fourier](fourier.md)
  - [Hypotrochoid](hypotrochoid.md) · [Lobed](lobed.md) · [Logarithmic spiral](logarithmic_spiral.md) · [Pascal](pascal.md) · [Superformula](superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](../tests/README.md)
  - [Tooth construction](tooth-construction.md) · [Tooth placement](tooth-placement.md) · [Mate motion](mate-motion.md) · [Mate generation](mate-generation.md) · [Pair assembly](pair-assembly.md)


## Module `Logarithmic Spiral`


The implemented sector form is `r=rmin*g^(2*pi*t)` with a radial return
between sectors. In local polar form this is `r(phi)=rmin exp(k phi)` with
`k=ln(growth_rate)`. Tooth count must be divisible by the sector count.
Reference: https://mathshistory.st-andrews.ac.uk/Curves/Equiangular/.

### Brief content:

**Functions**:

> [`_cg_logspiral_radius(rmin, growth_rate, t)`](#function-_cg_logspiral_radiusrmin-growth_rate-t): Evaluate the logarithmic-spiral radius at a sector parameter.

> [`_cg_logspiral_angle(sectors, sector, t)`](#function-_cg_logspiral_anglesectors-sector-t): Convert a spiral sector parameter to a polar angle.

> [`_cg_logspiral_point(rmin, growth_rate, sectors, sector, t)`](#function-_cg_logspiral_pointrmin-growth_rate-sectors-sector-t): Evaluate one Cartesian logarithmic-spiral point.

> [`_cg_logspiral_tangent(rmin, growth_rate, sectors, sector, t)`](#function-_cg_logspiral_tangentrmin-growth_rate-sectors-sector-t): Evaluate the tangent vector of the logarithmic spiral.

> [`_cg_logspiral_sector_points(rmin, growth_rate, sectors, sector, samples)`](#function-_cg_logspiral_sector_pointsrmin-growth_rate-sectors-sector-samples): Sample one logarithmic-spiral sector.

> [`_cg_logspiral_pitch_points`](#function-_cg_logspiral_pitch_points): Build the closed pitch polyline, retaining each radial sector return.

> [`_cg_logspiral_sector_length_for_rmin(rmin, growth_rate, sectors, samples)`](#function-_cg_logspiral_sector_length_for_rminrmin-growth_rate-sectors-samples): Calculate the sampled length of one spiral sector.

> [`_cg_logspiral_rmin(modul, tooth_number, sectors, growth_rate)`](#function-_cg_logspiral_rminmodul-tooth_number-sectors-growth_rate): Calculate the minimum radius for the requested tooth pitch.

> [`_cg_logspiral_rmax(modul, tooth_number, sectors, growth_rate)`](#function-_cg_logspiral_rmaxmodul-tooth_number-sectors-growth_rate): Calculate the maximum radius for the requested tooth pitch.

> [`curve_gear_logarithmic_spiral(modul, tooth_number, width, bore, ...)`](#function-curve_gear_logarithmic_spiralmodul-tooth_number-width-bore-): Build a logarithmic-spiral non-circular gear.

> [`_cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0,body_only=false)`](#function-_cg_logarithmic_spiral_buildmodultooth_numberwidthboresectors1growth_rate117pressure_angle20tooth_phase0backlashundefclearanceundefsamples360orientation0body_onlyfalse): Internal logarithmic spiral construction dispatcher.

> [`curve_gear_logarithmic_spiral_body(modul, tooth_number, width, bore, ...)`](#function-curve_gear_logarithmic_spiral_bodymodul-tooth_number-width-bore-): Build the logarithmic-spiral body solid without teeth.

> [`curve_gear_logarithmic_spiral_mate(modul, tooth_number, width, bore, ...)`](#function-curve_gear_logarithmic_spiral_matemodul-tooth_number-width-bore-): Build the standalone static reference mate boundary at the origin.

> [`curve_gear_logarithmic_spiral_reference_separation(modul, tooth_number, sectors, growth_rate, assembly_clearance)`](#function-curve_gear_logarithmic_spiral_reference_separationmodul-tooth_number-sectors-growth_rate-assembly_clearance): Return the explicit static reference separation for a spiral pair.

> [`curve_gear_logarithmic_spiral_pair(modul, tooth_number, width, bore, ...)`](#function-curve_gear_logarithmic_spiral_pairmodul-tooth_number-width-bore-): Build a meshed or separated logarithmic-spiral pair.

> [`_cg_logarithmic_spiral_pair_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,samples=360,together_built=true,assembly_clearance=0,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")`](#function-_cg_logarithmic_spiral_pair_buildmodultooth_numberwidthboresectors1growth_rate117pressure_angle20samples360together_builttrueassembly_clearance0backlashundefclearanceundeftooth_phase0driver_colorsteelbluemate_colorgold): Internal logarithmic spiral pair construction dispatcher.


## Functions

The module `Logarithmic Spiral` defines the following functions.

### Function `_cg_logspiral_radius(rmin, growth_rate, t)`


Evaluate the logarithmic-spiral radius at a sector parameter.

**Parameters:**

- `rmin`: {number > 0} Minimum radius in mm.
- `growth_rate`: {number > 1} Exponential growth base in the sector formula.
- `t`: {number} Normalised sector parameter.

**Returns:**

- `{number}`: Radius in mm.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_angle(sectors, sector, t)`


Convert a spiral sector parameter to a polar angle.

**Parameters:**

- `sectors`: {integer >= 1} Number of repeated sectors.
- `sector`: {integer >= 0} Sector index.
- `t`: {number} Normalised sector parameter.

**Returns:**

- `{angle}`: Polar angle in degrees.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_point(rmin, growth_rate, sectors, sector, t)`


Evaluate one Cartesian logarithmic-spiral point.

**Parameters:**

- `rmin`: {number > 0} Minimum radius in mm.
- `growth_rate`: {number > 1} Exponential growth base in the sector formula.
- `sectors`: {integer >= 1} Number of repeated sectors.
- `sector`: {integer >= 0} Sector index.
- `t`: {number} Normalised sector parameter.

**Returns:**

- `{array}`: Cartesian point `[x, y]` in mm.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_tangent(rmin, growth_rate, sectors, sector, t)`


Evaluate the tangent vector of the logarithmic spiral.

**Parameters:**

- `rmin`: {number > 0} Minimum radius in mm.
- `growth_rate`: {number > 1} Exponential growth base in the sector formula.
- `sectors`: {integer >= 1} Number of repeated sectors.
- `sector`: {integer >= 0} Sector index.
- `t`: {number} Normalised sector parameter.

**Returns:**

- `{array}`: Cartesian tangent vector.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_sector_points(rmin, growth_rate, sectors, sector, samples)`


Sample one logarithmic-spiral sector.

**Parameters:**

- `rmin`: {number > 0} Minimum radius in mm.
- `growth_rate`: {number > 1} Exponential growth base in the sector formula.
- `sectors`: {integer >= 1} Number of repeated sectors.
- `sector`: {integer >= 0} Sector index.
- `samples`: {integer >= 1, default 360} Number of samples.

**Returns:**

- `{array}`: Sector points in Cartesian coordinates.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_pitch_points`


Build the closed pitch polyline, retaining each radial sector return.

**Parameters:**

- `rmin`: {number > 0} Minimum radius in mm.
- `growth_rate`: {number > 1} Exponential growth base in the sector formula.
- `sectors`: {integer >= 1} Number of repeated sectors.
- `samples`: {integer >= 1, default 360} Samples per sector.

**Returns:**

- `{array of points}`: Closed logarithmic-spiral pitch polyline.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_sector_length_for_rmin(rmin, growth_rate, sectors, samples)`


Calculate the sampled length of one spiral sector.

**Parameters:**

- `rmin`: {number > 0} Minimum radius in mm.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.
- `sectors`: {integer >= 1, default 1} Number of repeated sectors.
- `samples`: {integer >= 1, default 360} Number of samples.

**Returns:**

- `{number}`: Sector length in mm.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_rmin(modul, tooth_number, sectors, growth_rate)`


Calculate the minimum radius for the requested tooth pitch.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `sectors`: {integer >= 1, default 1} Number of repeated sectors.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.

**Returns:**

- `{number}`: Minimum radius in mm.

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logspiral_rmax(modul, tooth_number, sectors, growth_rate)`


Calculate the maximum radius for the requested tooth pitch.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `sectors`: {integer >= 1, default 1} Number of repeated sectors.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.

**Returns:**

- `{number}`: Maximum radius in mm.

Back to [module description](#module-logarithmic-spiral).

### Function `curve_gear_logarithmic_spiral(modul, tooth_number, width, bore, ...)`


![Logarithmic spiral gear preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png)

Public single-gear construction for the logarithmic spiral family.
The gear is centred on X=0,Y=0 with its lower face at Z=0.
[`curve_gear_logarithmic_spiral_body`](#f-curve_gear_logarithmic_spiral_body)

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3 and divisible by sectors} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `sectors`: {integer >= 1, default 1} Number of repeated spiral sectors.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 360} Spiral sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_logarithmic_spiral(1, 24, 4, 8);
~~~

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0,body_only=false)`


Internal logarithmic spiral construction dispatcher.

**Parameters:**

- `modul`: {number} Tooth module in mm.
- `tooth_number`: {integer} Number of teeth.
- `width`: {number} Extrusion width in mm.
- `bore`: {number} Centre bore diameter in mm.
- `sectors`: {integer, default 1} Internal construction parameter.
- `growth_rate`: {number, default 1.17} Internal construction parameter.
- `pressure_angle`: {number, default 20} Involute pressure angle in degrees.
- `tooth_phase`: {number, default 0} Tooth placement phase in degrees.
- `backlash`: {number, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {number, default undef} Additional radial root clearance in mm.
- `samples`: {integer, default 360} Pitch-curve or motion-table sampling density.
- `orientation`: {number, default 0} Single-gear display rotation in degrees.
- `body_only`: {boolean, default false} Emit the body without teeth.

**Returns:**

- `{geometry}`: Constructed family geometry.

Back to [module description](#module-logarithmic-spiral).

### Function `curve_gear_logarithmic_spiral_body(modul, tooth_number, width, bore, ...)`


![Logarithmic spiral body preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png)

Build the logarithmic-spiral body solid without teeth.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `sectors`: {integer >= 1, default 1} Number of repeated spiral sectors.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 360} Spiral sampling density.
- `orientation`: {angle, default 0} Single-gear display rotation in degrees.

**Returns:**

No return

### Example:

~~~c
curve_gear_logarithmic_spiral_body(1, 24, 4, 8);
~~~

Back to [module description](#module-logarithmic-spiral).

### Function `curve_gear_logarithmic_spiral_mate(modul, tooth_number, width, bore, ...)`


![Logarithmic spiral mate preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.png)

A fixed 180-degree placement is applied by the static pair assembly; this
module does not claim dynamic conjugacy.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3 and divisible by sectors} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `sectors`: {integer >= 1, default 1} Number of repeated spiral sectors.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `samples`: {integer >= 120, default 360} Spiral sampling density.

**Returns:**

No return

Back to [module description](#module-logarithmic-spiral).

### Function `curve_gear_logarithmic_spiral_reference_separation(modul, tooth_number, sectors, growth_rate, assembly_clearance)`


Return the explicit static reference separation for a spiral pair.

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3 and divisible by sectors} Number of teeth.
- `sectors`: {integer >= 1, default 1} Number of repeated spiral sectors.
- `growth_rate`: {number > 1, default 1.17} Exponential growth base in the sector formula.
- `assembly_clearance`: {number >= 0, default 0} Additional separation in mm.

**Returns:**

- `{number}`: Static reference separation in mm.

Back to [module description](#module-logarithmic-spiral).

### Function `curve_gear_logarithmic_spiral_pair(modul, tooth_number, width, bore, ...)`


![Logarithmic spiral pair preview](../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.png)

Pair geometry uses the single-gear parameters documented in gear.scad.
[`curve_gear_logarithmic_spiral`](#f-curve_gear_logarithmic_spiral)

**Parameters:**

- `modul`: {number > 0} Tooth module in mm.
- `tooth_number`: {integer >= 3} Number of teeth.
- `width`: {number > 0} Extrusion width in mm.
- `bore`: {number >= 0} Centre bore diameter in mm.
- `sectors`: {integer >= 1, default 1} Number of spiral sectors.
- `growth_rate`: {number > 1, default 1.17} Radius growth per sector.
- `pressure_angle`: {0 < angle < 90, default 20} Involute pressure angle.
- `assembly_clearance`: {number >= 0, default 0} Explicit reference separation beyond the radial extents in mm.
- `backlash`: {undef or >= 0} Tangential tooth-thickness reduction in mm.
- `clearance`: {undef or >= 0} Additional radial root clearance in mm.
- `tooth_phase`: {angle, default 0} Tooth placement phase in degrees.
- `samples`: {integer >= 120, default 360} Spiral sampling density.
- `together_built`: {boolean, default true} Place the pair meshed when true, separated when false.
- `driver_color`: {OpenSCAD colour, default SteelBlue} Driver display colour.
- `mate_color`: {OpenSCAD colour, default Gold} Mate display colour.

**Returns:**

No return

### Example:

~~~c
curve_gear_logarithmic_spiral_pair(1, 24, 4, 8);
~~~

Back to [module description](#module-logarithmic-spiral).

### Function `_cg_logarithmic_spiral_pair_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,samples=360,together_built=true,assembly_clearance=0,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")`


Internal logarithmic spiral pair construction dispatcher.

**Parameters:**

- `modul`: {number} Tooth module in mm.
- `tooth_number`: {integer} Number of teeth.
- `width`: {number} Extrusion width in mm.
- `bore`: {number} Centre bore diameter in mm.
- `sectors`: {integer, default 1} Internal construction parameter.
- `growth_rate`: {number, default 1.17} Internal construction parameter.
- `pressure_angle`: {number, default 20} Involute pressure angle in degrees.
- `samples`: {integer, default 360} Pitch-curve or motion-table sampling density.
- `together_built`: {boolean, default true} Use meshed placement when true, display placement otherwise.
- `assembly_clearance`: {number, default 0} Internal construction parameter.
- `backlash`: {number, default undef} Tangential tooth-thickness reduction in mm.
- `clearance`: {number, default undef} Additional radial root clearance in mm.
- `tooth_phase`: {number, default 0} Tooth placement phase in degrees.
- `driver_color`: {string, default "SteelBlue"} Driver display colour.
- `mate_color`: {string, default "Gold"} Mate display colour.

**Returns:**

- `{geometry}`: Constructed family geometry.

Back to [module description](#module-logarithmic-spiral).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
