/***
 * @module Mate envelope
 * @brief Build a mate blank from the swept envelope of a prescribed gear motion.
 *
 * Family adapters provide a complete driver outline, its phase table and the
 * fixed centre distance. This shared layer samples that motion in the mate
 * frame and subtracts the swept driver from a circular blank. Adaptive angular
 * subdivision and positive cutter clearance reduce gaps between sampled poses.
 * It requires `curve_gears_math.scad` and the family motion table to be loaded.
 */
include <motion.scad>

/***
 * @module _cg_mate_from_swept_outline(driver_outline, motion, centre_distance, mate_outer_radius, width, bore, modul, ...)
 * @brief Cut a sampled swept-envelope receiver from a circular mate blank.
 * @param driver_outline {array of points} Complete placed driver outline in driver-local coordinates.
 * @param motion {motion table} Driver-to-mate motion table.
 * @param centre_distance {number > 0} Fixed separation of the rotation axes.
 * @param mate_outer_radius {number > 0} Outer radius of the mate blank.
 * @param width {number > 0} Extrusion width.
 * @param bore {number >= 0} Mate centre bore diameter.
 * @param modul {number > 0} Tooth module, used to scale sweep clearance.
 * @param sweep_steps {integer >= 36, default 360} Base driver-phase intervals over one turn.
 * @param max_pose_step {number > 0, default 0.5} Maximum driver or mate rotation step in degrees.
 * @param sweep_clearance {number > 0, default 0.08} Cutter expansion as a module fraction.
 * @param phase {angle, default 0} Driver phase for the displayed mate pose.
 * @return {geometry} Circular blank with the driver's sampled swept path removed.
 */
function _cg_mate_envelope_motion_valid(motion) = len(motion)<2 ? false :
    _cg_polyline_finite(motion)
    && abs(motion[0][0])<_cg_tolerance && abs(motion[0][1])<_cg_tolerance
    && abs(motion[len(motion)-1][0]-360)<_cg_tolerance
    && min([for(i=[0:len(motion)-2]) motion[i+1][0]>motion[i][0] ? 1 : 0])==1
    && min([for(i=[0:len(motion)-2]) motion[i+1][1]>=motion[i][1]-_cg_tolerance ? 1 : 0])==1
    && abs(_cg_motion_closure_error(motion))<.08;
function _cg_mate_sweep_max_motion_slope_from(motion,driver1,index) =
    index>=len(motion)-1 || motion[index][0]>=driver1 ? 0 :
    max(abs((motion[index+1][1]-motion[index][1])/(motion[index+1][0]-motion[index][0])),
        _cg_mate_sweep_max_motion_slope_from(motion,driver1,index+1));
function _cg_mate_sweep_max_motion_slope(motion,driver0,driver1) =
    _cg_mate_sweep_max_motion_slope_from(motion,driver1,
        max(0,_cg_upper_bound_column(motion,driver0,0,0,len(motion)-1)));
function _cg_mate_sweep_subdivisions(motion,sweep_steps,max_pose_step) =
    [for(i=[0:sweep_steps-1])
        let(driver0=360*i/sweep_steps,driver1=360*(i+1)/sweep_steps,
            mate_step=_cg_mate_sweep_max_motion_slope(motion,driver0,driver1)*(driver1-driver0))
        max(1,ceil(max(driver1-driver0,mate_step)/max_pose_step))];
function _cg_mate_sweep_pose_count(motion,sweep_steps=360,max_pose_step=.5) =
    _cg_sum(_cg_mate_sweep_subdivisions(motion,sweep_steps,max_pose_step));

module _cg_mate_from_swept_outline(driver_outline,motion,centre_distance,mate_outer_radius,width,bore,modul,sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,phase=0) {
    assert(len(driver_outline)>=3 && _cg_polyline_finite(driver_outline),
        "mate_envelope: driver_outline must contain at least three finite points");
    assert(_cg_mate_envelope_motion_valid(motion),
        "mate_envelope: motion must be a finite, closed 360-degree phase table");
    assert(centre_distance>0 && mate_outer_radius>bore/2 && width>0 && modul>0,
        "mate_envelope: distance, blank radius, width and module must be positive");
    assert(bore>=0 && sweep_clearance>0 && max_pose_step>0 && floor(sweep_steps)==sweep_steps && sweep_steps>=36,
        "mate_envelope: bore must be non-negative; clearance and max_pose_step positive; sweep_steps >= 36");
    subdivisions=_cg_mate_sweep_subdivisions(motion,sweep_steps,max_pose_step);
    rotate([0,0,_cg_mate_rotation_for_phase(motion,phase)])
        linear_extrude(height=width,center=true,convexity=10)
            difference() {
                circle(r=mate_outer_radius,$fn=max(180,sweep_steps*2));
                for(i=[0:sweep_steps-1])
                    for(j=[0:subdivisions[i]-1]) {
                        driver_phase=360*(i+j/subdivisions[i])/sweep_steps;
                        mate_rotation=_cg_mate_rotation_for_phase(motion,driver_phase);
                        rotate([0,0,-mate_rotation])
                            translate([-centre_distance,0,0])
                                rotate([0,0,driver_phase])
                                    offset(r=sweep_clearance*modul)
                                        polygon(points=driver_outline);
                }
                if(bore>0) circle(d=bore,$fn=96);
            }
}
