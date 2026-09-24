/***
 * Public single-gear construction for the logarithmic spiral family.
 * @function curve_gear_logarithmic_spiral(modul, tooth_number, width, bore, ...)
 * @brief Build a logarithmic-spiral non-circular gear.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png Logarithmic spiral gear preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3 and divisible by sectors} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param sectors {integer >= 1, default 1} Number of repeated spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Spiral sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_logarithmic_spiral_body
 * @example c
 * curve_gear_logarithmic_spiral(1, 24, 4, 8);
 */
include <base.scad>

module _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0,body_only=false) {
/***
 * @function _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0,body_only=false)
 * @brief Internal logarithmic spiral construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param sectors {integer, default 1} Internal construction parameter.
 * @param growth_rate {number, default 1.17} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 360} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    assert(sectors >= 1 && floor(sectors)==sectors,"logarithmic_spiral_gear: sectors must be an integer >= 1");
    assert(tooth_number >= 3 && floor(tooth_number)==tooth_number,"logarithmic_spiral_gear: tooth_number must be an integer >= 3");
    assert(tooth_number % sectors == 0,"logarithmic_spiral_gear: tooth_number must be divisible by sectors");
    assert(growth_rate > 1,"logarithmic_spiral_gear: growth_rate must be > 1");

    rmin=_cg_logspiral_rmin(modul,tooth_number,sectors,growth_rate);

    assert(samples >= 120 && floor(samples)==samples,"samples must be an integer >= 120");
    // The shared builder keeps the spiral and its radial returns in one
    // canonical 2D boundary.  Long return segments are evaluated as
    // inaccessible tooth corridors, so no ordinary tooth is placed there.
    points=_cg_logspiral_pitch_points(rmin,growth_rate,sectors,samples);
    rotate([0,0,orientation])
        _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,true,backlash,clearance,body_only);
}

// Single gear; mm dimensions, degree angles, Z=0 lower face.
module curve_gear_logarithmic_spiral(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0) {
    _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_logarithmic_spiral_body(modul, tooth_number, width, bore, ...)
 * @brief Build the logarithmic-spiral body solid without teeth.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png Logarithmic spiral body preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param sectors {integer >= 1, default 1} Number of repeated spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Spiral sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_logarithmic_spiral_body(1, 24, 4, 8);
 */
// Body solid without teeth.
module curve_gear_logarithmic_spiral_body(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0) {
    _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}
