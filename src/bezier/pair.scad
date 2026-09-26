// Meshed pair using the admissible Bézier radial mate adapter.
include <mate.scad>
include <../pair/assembly.scad>

/**
 * @function curve_gear_bezier_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated pair from an admissible Bézier curve.
 * @image ../images/functions/bezier/curve_gear_bezier_pair.png Bézier pair preview
 * @image ../images/functions/bezier/curve_gear_bezier_pair_alternative.png Bézier asymmetric alternative pair
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param control_points {closed array grouped as 3n+1 points} Bézier controls.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param samples {integer >= 120, default 720} Adapter and pitch sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Build the pair as one assembled object when true.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param driver_color {colour, default SteelBlue} Driver gear colour.
 * @param mate_color {colour, default Gold} Mate gear colour.
 */
module curve_gear_bezier_pair(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"bezier_gear_pair: samples must be an integer >= 120");
    scale=modul*tooth_number/2;
    admissibility=_cg_bezier_mate_admissibility(control_points,scale,samples);
    assert(admissibility=="PASS",str("bezier_gear_pair: mate-admissibility failure code=",admissibility));
    table=_cg_bezier_polar_table(control_points,scale,samples);
    driver=_cg_bezier_points(control_points,scale,samples);
    driver_radii=_cg_bezier_driver_radii_from_table(table,samples);
    mid_radii=_cg_bezier_mid_radii_from_table(table,samples);
    mx=max(mid_radii);
    D=_cg_solve_mate_distance(mid_radii,mx+.01,4*mx);
    integration_state=_cg_motion_integration_state(driver_radii,mid_radii,D);
    motion=integration_state[2];
    mate=_cg_mate_points_from_radius_samples_with_state(driver_radii,D,integration_state);
    _cg_pair_assembly(D,motion,phase,together_built,_cg_pair_point_extent(driver),_cg_pair_point_extent(mate),modul,driver,mate,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,false,false,driver_color,mate_color);
}
