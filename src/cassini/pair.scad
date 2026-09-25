/**
 * @function curve_gear_cassini_pair
 * @brief Build a meshed or separated Cassini driver/mate pair.
 * @image ../images/functions/cassini/curve_gear_cassini_pair.png Cassini pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param focus_ratio {0 <= number < 1, default 0.78} Cassini focal ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param samples {integer >= 120, default 720} Pitch-curve and motion sampling density.
 * @param phase {angle, default 0} Driver motion phase.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param together_built {boolean, default true} Place the pair meshed when true.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * @example c
 * curve_gear_cassini_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module _cg_cassini_pair_build(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(_cg_cassini_focus_ratio_valid(focus_ratio),"cassini_gear_pair: focus_ratio must satisfy 0 <= focus_ratio < 1");
    assert(samples >= 120 && floor(samples)==samples,"cassini_gear_pair: samples must be an integer >= 120");
    scale=_cg_cassini_scale(modul,tooth_number,focus_ratio,samples);
    D=_cg_cassini_centre_distance(scale,focus_ratio,samples);
    motion=_cg_cassini_motion_table(scale,focus_ratio,D,samples);
    closure_error=motion[len(motion)-1][1]-360;
    assert(abs(closure_error) < .08,"cassini_gear_pair: conjugate closure error too large");
    driver=_cg_cassini_points(scale,focus_ratio,samples);
    mate=_cg_cassini_mate_points_from_driver(scale,focus_ratio,D,samples);
    _cg_pair_assembly(D,motion,phase,together_built,max([for(p=driver) _cg_vlen(p)]),max([for(p=mate) _cg_vlen(p)]),modul,driver,mate,tooth_number,pressure_angle,tooth_phase,backlash,clearance) {
        color(driver_color) curve_gear_cassini(modul,tooth_number,width,bore,focus_ratio,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_cassini_mate(modul,tooth_number,width,bore,focus_ratio,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}

module curve_gear_cassini_pair(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_cassini_pair_build(modul,tooth_number,width,bore,focus_ratio,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
