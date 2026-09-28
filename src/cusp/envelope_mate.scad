/* Build a swept-envelope receiver for the deltoid cusp driver. The family
 * adapter supplies the motion table and blank size; shared envelope code
 * constructs the receiver from the complete validated driver outline.
 */
include <gear.scad>
include <../common/mate/envelope.scad>

/***
 * @function _cg_cusp_envelope_driver_outline(state)
 * @brief Extract the complete placed driver outline from its validated state.
 * @param state {array} Validated cusp tooth-geometry state.
 * @return {array of points} Closed outline in millimetres.
 */
function _cg_cusp_envelope_driver_outline(state) = len(state)>=12 ? state[7] : [];
/***
 * @function _cg_cusp_envelope_mate_outer_radius(geometry, modul)
 * @brief Calculate the swept-envelope mate's outer blank radius.
 * @param geometry {array} Cusp pitch and motion geometry state.
 * @param modul {number > 0} Tooth module in millimetres.
 * @return {number} Mate blank radius in millimetres.
 */
function _cg_cusp_envelope_mate_outer_radius(geometry,modul) =
    geometry[3]-min(geometry[1])+_cg_addendum(modul);

/***
 * @function _cg_cusp_envelope_mate_from_geometry(geometry, modul, width, bore, sweep_steps=360, max_pose_step=0.5, sweep_clearance=0.08, phase=0)
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
