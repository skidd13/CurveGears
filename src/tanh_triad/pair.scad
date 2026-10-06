include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_tanh_triad_pair
 * @brief Build a Tanh Triad gear pair.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_pair.png Tanh Triad pair preview
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param transition {number} Transition.
 * @param crest {number} Crest.
 * @param correction {number} Correction.
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
module curve_gear_tanh_triad_pair(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"tanh_triad_gear_pair: samples must be an integer >= 120");
    unit_points=_cg_tanh_triad_unit_points(samples,transition,crest,correction);
    scale=_cg_tanh_triad_scale(modul,tooth_number,samples,transition,crest,correction,unit_points);
    driver=_cg_scale_points(scale,unit_points);
    driver_radii=_cg_tanh_triad_driver_radii(scale,transition,crest,correction,samples);
    mid_radii=_cg_tanh_triad_motion_radii(scale,transition,crest,correction,samples);
    D=_cg_tanh_triad_centre_distance(scale,transition,crest,correction,samples);
    state=_cg_motion_integration_state(driver_radii,mid_radii,D);
    motion=state[2];
    assert(abs(_cg_motion_closure_error(motion))<.08,"tanh_triad_gear_pair: conjugate closure error too large");
    mate=_cg_mate_points_from_radius_samples_with_state(driver_radii,D,state);
    _cg_pair_assembly(D,motion,phase,together_built,_cg_pair_point_extent(driver),_cg_pair_point_extent(mate),modul,driver,mate,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,false,false,driver_color,mate_color);
}
