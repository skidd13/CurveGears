/***
 * @function curve_gear_lobed_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated lobed pair.
 * @image ../images/functions/lobed/curve_gear_lobed_pair.png Lobed pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param lobes {integer >= 2, default 4} Number of lobes.
 * @param lobe_depth {0 < depth < 0.5, default 0.13} Lobe depth as a fraction of the mean radius.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param phase {angle, default 0} Pair motion phase in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * Pair geometry uses the single-gear parameters documented in gear.scad.
  * @see curve_gear_lobed
 * @example c
 * curve_gear_lobed_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module _cg_lobed_pair_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
/***
 * @function _cg_lobed_pair_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")
 * @brief Internal lobed pair construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param lobes {integer, default 4} Internal construction parameter.
 * @param lobe_depth {number, default 0.13} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
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
    assert(lobes >= 2 && floor(lobes)==lobes,"lobed_gear_pair: lobes must be an integer >= 2");
    assert(lobe_depth > 0 && lobe_depth < 0.5,"lobed_gear_pair: lobe_depth must satisfy 0 < lobe_depth < 0.5");
    assert(samples >= 120 && floor(samples)==samples,"lobed_gear_pair: samples must be an integer >= 120");
    scale=_cg_lobed_scale(modul,tooth_number,lobes,lobe_depth,samples);
    D=_cg_lobed_centre_distance(scale,lobes,lobe_depth,samples);
    motion=_cg_lobed_motion_table(scale,lobes,lobe_depth,D,samples);
    closure_error=motion[len(motion)-1][1]-360;
    assert(abs(closure_error) < 0.08,"lobed_gear_pair: conjugate closure error too large");
    driver=[for(i=[0:samples-1]) _cg_lobed_point(scale,lobes,lobe_depth,360*i/samples)];
    mate=_cg_lobed_mate_points_from_driver(scale,lobes,lobe_depth,D,samples);
    _cg_pair_assembly(D,motion,phase,together_built,max([for(p=driver) _cg_vlen(p)]),max([for(p=mate) _cg_vlen(p)]),modul,driver,mate,tooth_number,pressure_angle,tooth_phase,backlash,clearance) {
        color(driver_color) curve_gear_lobed(modul,tooth_number,width,bore,lobes,lobe_depth,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_lobed_mate(modul,tooth_number,width,bore,lobes,lobe_depth,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}

module curve_gear_lobed_pair(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_lobed_pair_build(modul,tooth_number,width,bore,lobes,lobe_depth,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
