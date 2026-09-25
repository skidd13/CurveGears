/***
 * @function curve_gear_superformula_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated superformula pair from validated 2D boundaries.
 * @image ../images/functions/superformula/curve_gear_superformula_pair.png Superformula pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula horizontal scale.
 * @param b {number > 0, default 1} Superformula vertical scale.
 * @param n1 {number > 0, default 2.4} Superformula exponent n1.
 * @param n2 {number > 0, default 2.4} Superformula exponent n2.
 * @param n3 {number > 0, default 2.4} Superformula exponent n3.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @param phase {angle, default 0} Pair motion phase in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * Pair geometry uses the single-gear parameters documented in gear.scad.
  * @see curve_gear_superformula
 * @example c
 * curve_gear_superformula_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module _cg_superformula_pair_build(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,samples=360,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
/***
 * @function _cg_superformula_pair_build(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,samples=360,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")
 * @brief Internal superformula pair construction dispatcher.
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
 * @param samples {integer, default 360} Pitch-curve or motion-table sampling density.
 * @param phase {number, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Use meshed placement when true, display placement otherwise.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param driver_color {string, default "SteelBlue"} Driver display colour.
 * @param mate_color {string, default "Gold"} Mate display colour.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    assert(symmetry >= 2 && floor(symmetry)==symmetry,"superformula_gear_pair: symmetry must be an integer >= 2");
    assert(a>0 && b>0 && n1>0 && n2>0 && n3>0,"superformula_gear_pair: a,b,n1,n2,n3 must be positive");
    assert(_cg_superformula_odd_valid(symmetry,a,b,n2,n3),"superformula_gear_pair: odd symmetry requires a=b and n2=n3 for 360-degree continuity");
    assert(samples >= 120 && floor(samples)==samples,"superformula_gear_pair: samples must be an integer >= 120");
    scale=_cg_superformula_scale(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples);
    D=_cg_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,samples);
    motion=_cg_superformula_motion_table(scale,symmetry,a,b,n1,n2,n3,D,samples);
    closure_error=motion[len(motion)-1][1]-360;
    assert(abs(closure_error) < 0.08,"superformula_gear_pair: conjugate closure error too large");
    driver=_cg_superformula_points(scale,symmetry,a,b,n1,n2,n3,samples);
    mate=_cg_superformula_mate_points_from_driver(scale,symmetry,a,b,n1,n2,n3,D,samples);
    _cg_pair_assembly(D,motion,phase,together_built,max([for(p=driver) _cg_vlen(p)]),max([for(p=mate) _cg_vlen(p)]),modul,driver,mate,tooth_number,pressure_angle,tooth_phase,backlash,clearance) {
        color(driver_color) curve_gear_superformula(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_superformula_mate(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}

module curve_gear_superformula_pair(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,samples=360,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_superformula_pair_build(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
