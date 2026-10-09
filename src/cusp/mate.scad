include <gear.scad>
include <../common/mate/envelope.scad>

/***
 * @function _cg_cusp_envelope_driver_outline
 * @brief Extract the complete placed driver outline from its validated state.
 * @param state {array} Validated cusp tooth-geometry state.
 * @return {array of points} Closed outline in millimetres.
 */
function _cg_cusp_envelope_driver_outline(state) = len(state)>=12 ? state[7] : [];

/***
 * @function _cg_cusp_envelope_mate_outer_radius
 * @brief Calculate the swept-envelope mate's outer blank radius.
 * @param geometry {array} Cusp pitch and motion geometry state.
 * @param modul {number > 0} Tooth module in millimetres.
 * @return {number} Mate blank radius in millimetres.
 */
function _cg_cusp_envelope_mate_outer_radius(geometry,modul) =
    geometry[3]-min(geometry[1])+_cg_addendum(modul);

/***
 * @function _cg_cusp_envelope_mate_from_geometry
 * @brief Build the cusp mate by sweeping the complete validated driver outline.
 * @param geometry {array} Validated cusp pitch and motion state.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param width {number > 0} Extrusion width in millimetres.
 * @param bore {number >= 0} Centre bore diameter in millimetres.
 * @param sweep_steps {integer >= 36, default 360} Base driver-phase intervals.
 * @param max_pose_step {number > 0, default 0.5} Maximum member pose step in degrees.
 * @param sweep_clearance {number > 0, default 0.08} Cutter clearance as a module fraction.
 * @param phase {angle, default 0} Driver phase in degrees.
 */
module _cg_cusp_envelope_mate_from_geometry(geometry,modul,width,bore,sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,phase=0) {
    driver_state=geometry[0];
    assert(_cg_tooth_geometry_state_valid(driver_state),
        "cusp_envelope_mate: driver must pass shared tooth placement and outline validation");
    driver_outline=_cg_cusp_envelope_driver_outline(driver_state);
    centre_distance=geometry[3];
    mate_outer_radius=_cg_cusp_envelope_mate_outer_radius(geometry,modul);
    _cg_mate_from_swept_outline(driver_outline,geometry[4][2],centre_distance,mate_outer_radius,width,bore,modul,sweep_steps,max_pose_step,sweep_clearance,phase);
}

/***
 * @function curve_gear_cusp_mate
 * @brief Build the standalone swept-envelope mate for a cusp gear.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Shared tooth count.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Tooth pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 720, divisible by cusps, default 720} Motion and pitch-curve sampling density for the validated cusp outline.
 * @param sweep_steps {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
 * @param max_pose_step {number > 0, default 0.5} Maximum angular step of either member in degrees.
 * @param sweep_clearance {number > 0, default 0.08} Envelope cutter clearance as a module fraction.
 * @param phase {angle, default 0} Driver phase used to orient the displayed mate.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 */
module curve_gear_cusp_mate(modul,tooth_number,width,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,phase=0,cusps=3) {
    assert(cusps>=3 && floor(cusps)==cusps,"cusp_gear: cusps must be an integer >= 3");
    assert(tooth_number>=cusps && floor(tooth_number)==tooth_number && tooth_number%cusps==0,
        "cusp_gear_mate: tooth_number must be an integer divisible by cusps");
    _cg_assert_samples(samples,"cusp_gear_mate: samples must be an integer >= 720 for the validated cusp outline",720);
    assert(samples%cusps==0,"cusp_gear_mate: samples must be divisible by cusps");
    geometry=_cg_cusp_pair_motion_geometry(modul,tooth_number,pressure_angle,backlash,clearance,samples,cusps);
    _cg_cusp_envelope_mate_from_geometry(geometry,modul,width,bore,sweep_steps,max_pose_step,sweep_clearance,phase);
}

/***
 * @function curve_gear_cusp_centre_distance
 * @brief Return the solved pitch-curve centre distance for a cusp pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Shared tooth count.
 * @param samples {integer >= 120, divisible by cusps, default 720} Motion sampling density.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {number} Fixed centre distance in mm.
 */
function curve_gear_cusp_centre_distance(modul,tooth_number,samples=720,cusps=3) =
    _cg_cusp_pair_motion_geometry(modul,tooth_number,20,undef,undef,samples,cusps)[3];

/***
 * @function curve_gear_cusp_mate_rotation
 * @brief Return the integrated mate angle at one driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Shared tooth count.
 * @param samples {integer >= 120, divisible by cusps, default 720} Motion sampling density.
 * @param phase {angle, default 0} Driver angle in degrees.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {angle} Mate display rotation in degrees.
 */
function curve_gear_cusp_mate_rotation(modul,tooth_number,samples=720,phase=0,cusps=3) =
    let(geometry=_cg_cusp_pair_motion_geometry(modul,tooth_number,20,undef,undef,samples,cusps),motion=geometry[4][2])
    _cg_mate_rotation_for_phase(motion,phase);
