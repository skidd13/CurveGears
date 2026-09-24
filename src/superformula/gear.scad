/***
 * Public single-gear construction for the superformula family.
 * @function curve_gear_superformula(modul, tooth_number, width, bore, ...)
 * @brief Build a superformula non-circular gear.
 * @image ../images/functions/superformula/curve_gear_superformula.png Superformula gear preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * Odd symmetry requires a=b and n2=n3 for full-turn continuity.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_superformula_body
 * @example c
 * curve_gear_superformula(1, 24, 4, 8);
 */
include <base.scad>

module _cg_superformula_build(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false) {
/***
 * @function _cg_superformula_build(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)
 * @brief Internal superformula construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param symmetry {integer, default 4} Internal construction parameter.
 * @param a {value, default 1} Internal construction parameter.
 * @param b {value, default 1} Internal construction parameter.
 * @param n1 {value, default 2.4} Internal construction parameter.
 * @param n2 {value, default 2.4} Internal construction parameter.
 * @param n3 {value, default 2.4} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    assert(symmetry >= 2 && floor(symmetry)==symmetry,"superformula_gear: symmetry must be an integer >= 2");
    assert(a>0 && b>0 && n1>0 && n2>0 && n3>0,"superformula_gear: a,b,n1,n2,n3 must be positive");
    assert(_cg_superformula_odd_valid(symmetry,a,b,n2,n3),"superformula_gear: odd symmetry requires a=b and n2=n3 for 360-degree continuity");

    scale=_cg_superformula_scale(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples);
    points=_cg_superformula_points(scale,symmetry,a,b,n1,n2,n3,samples);

    assert(samples >= 120 && floor(samples)==samples,"samples must be an integer >= 120");
    // Drawing
    rotate([0,0,orientation]) _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

// Single gear; mm dimensions, degree angles, Z=0 lower face.
module curve_gear_superformula(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_superformula_build(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_superformula_body(modul, tooth_number, width, bore, ...)
 * @brief Build the superformula body solid without teeth.
 * @image ../images/functions/superformula/curve_gear_superformula_body.png Superformula body preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_superformula_body(1, 24, 4, 8);
 */
// Body solid without teeth.
module curve_gear_superformula_body(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_superformula_build(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}
