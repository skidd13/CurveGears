/***
 * @module Cusp envelope mate
 * @brief Build a swept-envelope receiver for the deltoid cusp driver.
 *
 * The family adapter supplies the deltoid motion table and outer blank size;
 * shared envelope code constructs the receiver from the complete validated
 * driver outline.
 */
include <gear.scad>
include <../mate/envelope.scad>

function _cg_cusp_envelope_driver_outline(state) = len(state)>=12 ? state[7] : [];
function _cg_cusp_envelope_mate_outer_radius(geometry,modul) =
    geometry[3]-min(geometry[1])+_cg_addendum(modul);

module _cg_cusp_envelope_mate_from_geometry(geometry,modul,width,bore,sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,phase=0) {
    driver_state=geometry[0];
    assert(_cg_tooth_geometry_state_valid(driver_state),
        "cusp_envelope_mate: driver must pass shared tooth placement and outline validation");
    driver_outline=_cg_cusp_envelope_driver_outline(driver_state);
    centre_distance=geometry[3];
    mate_outer_radius=_cg_cusp_envelope_mate_outer_radius(geometry,modul);
    _cg_mate_from_swept_outline(driver_outline,geometry[4][2],centre_distance,mate_outer_radius,width,bore,modul,sweep_steps,max_pose_step,sweep_clearance,phase);
}
