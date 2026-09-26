/***
 * @function curve_gear_epitrochoid_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated epitrochoid pair.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_pair.png Epitrochoid pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
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
  * @see curve_gear_epitrochoid
 * @example c
 * curve_gear_epitrochoid_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module curve_gear_epitrochoid_pair(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(major_ratio > rolling_ratio && rolling_ratio > 0 && offset_ratio > 0 && offset_ratio < rolling_ratio,"epitrochoid: require major_ratio > rolling_ratio > 0 and 0 < offset_ratio < rolling_ratio");
    _cg_assert_samples(samples,"epitrochoid pair: samples must be an integer >= 120");
    scale=_cg_epitrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples);
    mid_radii=_cg_epitrochoid_motion_radii(scale,major_ratio,rolling_ratio,offset_ratio,samples);
    mx=max([for(p=_cg_epitrochoid_points_scaled(scale,major_ratio,rolling_ratio,offset_ratio,720)) _cg_vlen(p)]);
    D=_cg_solve_mate_distance(mid_radii,mx+.01,4*mx);
    driver_radii=_cg_epitrochoid_driver_radii(scale,major_ratio,rolling_ratio,offset_ratio,samples);
    integration_state=_cg_motion_integration_state(driver_radii,mid_radii,D);
    motion=integration_state[2];
    driver=_cg_epitrochoid_points_scaled(scale,major_ratio,rolling_ratio,offset_ratio,samples);
    mate=_cg_mate_points_from_radius_samples_with_state(driver_radii,D,integration_state);
    assert(abs(motion[len(motion)-1][1]-360) < 0.08,"epitrochoid pair: rolling closure error too large");
    _cg_pair_assembly(D,motion,phase,together_built,_cg_pair_point_extent(driver),_cg_pair_point_extent(mate),modul,driver,mate,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,false,false,driver_color,mate_color);
}
