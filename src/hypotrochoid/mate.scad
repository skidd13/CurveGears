include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

function _cg_hypotrochoid_motion_radii(scale,R,r,d,n=720) = [for(i=[0:n-1]) _cg_hypotrochoid_curve_radius(scale,R,r,d,360*(i+.5)/n)];
function _cg_hypotrochoid_driver_radii(scale,R,r,d,n=720) = [for(i=[0:n-1]) _cg_hypotrochoid_curve_radius(scale,R,r,d,360*i/n)];
function _cg_hypotrochoid_centre_distance(scale,R,r,d,n=720) = let(points=_cg_hypotrochoid_points_scaled(scale,R,r,d,1440),mx=max([for(p=points) _cg_vlen(p)])) _cg_solve_mate_distance(_cg_hypotrochoid_motion_radii(scale,R,r,d,n),mx+.01,4*mx);
function _cg_hypotrochoid_motion_table(scale,R,r,d,D,n=720) = _cg_motion_table_from_mid_radii(_cg_hypotrochoid_motion_radii(scale,R,r,d,n),D);
function _cg_hypotrochoid_mate_points_from_driver(scale,R,r,d,D,n=720) = _cg_mate_points_from_radius_samples(_cg_hypotrochoid_driver_radii(scale,R,r,d,n),_cg_hypotrochoid_motion_radii(scale,R,r,d,n),D);
function _cg_hypotrochoid_mate_points(scale,R,r,d,D,n=720) = _cg_hypotrochoid_mate_points_from_driver(scale,R,r,d,D,n);

/** @function curve_gear_hypotrochoid_mate
 * @brief Build the standalone conjugate mate for a hypotrochoid driver.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_mate.png Hypotrochoid mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 */
module curve_gear_hypotrochoid_mate(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    assert(samples>=120 && floor(samples)==samples,"hypotrochoid_gear_mate: samples must be an integer >= 120");
    scale=_cg_hypotrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples);
    D=_cg_hypotrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio,samples);
    mate=_cg_hypotrochoid_mate_points(scale,major_ratio,rolling_ratio,offset_ratio,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/** @function curve_gear_hypotrochoid_centre_distance
 * @brief Return the mathematical centre distance for a hypotrochoid pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param samples {integer >= 120, default 720} Motion sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_hypotrochoid_centre_distance(modul,tooth_number,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=720) = let(scale=_cg_hypotrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples)) _cg_hypotrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio,samples);

/** @function curve_gear_hypotrochoid_mate_rotation
 * @brief Return the conjugate hypotrochoid mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param samples {integer >= 120, default 720} Motion sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_hypotrochoid_mate_rotation(modul,tooth_number,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=720,phase=0) = let(scale=_cg_hypotrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples),D=_cg_hypotrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio,samples),motion=_cg_hypotrochoid_motion_table(scale,major_ratio,rolling_ratio,offset_ratio,D,samples)) _cg_mate_rotation_for_phase(motion,phase);
