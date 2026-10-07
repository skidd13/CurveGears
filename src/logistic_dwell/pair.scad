include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_logistic_dwell_pair
 * @brief Build a Logistic Dwell gear pair.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair.png Logistic Dwell pair preview
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param gain {number} Logistic gain.
 * @param depth {number} Dwell depth.
 * @param pressure_angle {number} Pressure angle.
 * @param samples {integer} Samples.
 * @param phase {number} Pair phase.
 * @param together_built {boolean} Mesh pair.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param tooth_phase {number} Tooth phase.
 * @param driver_color {string} Driver colour.
 * @param mate_color {string} Mate colour.
 */
module curve_gear_logistic_dwell_pair(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"logistic_dwell_gear_pair: samples must be an integer >= 120");
    unit_points=_cg_logistic_dwell_unit_points(samples,gain,depth);
    scale=_cg_logistic_dwell_scale(modul,tooth_number,samples,gain,depth,unit_points);
    driver=_cg_scale_points(scale,unit_points);
    driver_radii=_cg_logistic_dwell_driver_radii(scale,gain,depth,samples);
    mid_radii=_cg_logistic_dwell_motion_radii(scale,gain,depth,samples);
    D=_cg_logistic_dwell_centre_distance(scale,gain,depth,samples);
    state=_cg_motion_integration_state(driver_radii,mid_radii,D);
    motion=state[2];
    mate=_cg_mate_points_from_radius_samples_with_state(driver_radii,D,state);
    _cg_pair_assembly(D,motion,phase,together_built,_cg_pair_point_extent(driver),_cg_pair_point_extent(mate),modul,driver,mate,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,false,false,driver_color,mate_color);
}
