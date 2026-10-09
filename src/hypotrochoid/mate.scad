include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/motion.scad>
include <../common/mate/placement.scad>

/***
 * @function _cg_hypotrochoid_motion_radii
 * @brief Sample the driver polygon at physical polar integration midpoints.
 * @param scale {number > 0} Curve scale in millimetres.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number >= 0} Pen offset ratio.
 * @param n {integer >= 3, default 720} Number of motion intervals.
 * @return {array of number} Midpoint pitch radii.
 */
function _cg_hypotrochoid_motion_radii(scale,R,r,d,n=720) = _cg_trochoid_polar_radii(_cg_hypotrochoid_points_scaled(scale,R,r,d,n),n,true);
/***
 * @function _cg_hypotrochoid_driver_radii
 * @brief Sample the driver polygon at physical polar phase boundaries.
 * @param scale {number > 0} Curve scale in millimetres.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number >= 0} Pen offset ratio.
 * @param n {integer >= 3, default 720} Number of phase intervals.
 * @return {array of number} Driver pitch radii.
 */
function _cg_hypotrochoid_driver_radii(scale,R,r,d,n=720) = _cg_trochoid_polar_radii(_cg_hypotrochoid_points_scaled(scale,R,r,d,n),n,false);
/***
 * @function _cg_hypotrochoid_centre_distance
 * @brief Solve the fixed centre distance for a hypotrochoid mate.
 * @param scale {number > 0} Curve scale in millimetres.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number >= 0} Pen offset ratio.
 * @param n {integer >= 1, default 720} Number of motion intervals.
 * @return {number} Solved centre distance in millimetres.
 */
function _cg_hypotrochoid_centre_distance(scale,R,r,d,n=720) = let(points=_cg_hypotrochoid_points_scaled(scale,R,r,d,1440),mx=max([for(p=points) _cg_vlen(p)])) _cg_solve_mate_distance(_cg_hypotrochoid_motion_radii(scale,R,r,d,n),mx+.01,4*mx);
/***
 * @function _cg_hypotrochoid_motion_table
 * @brief Integrate hypotrochoid driver-to-mate phase motion.
 * @param scale {number > 0} Curve scale in millimetres.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number >= 0} Pen offset ratio.
 * @param D {number > 0} Fixed centre distance in millimetres.
 * @param n {integer >= 1, default 720} Number of motion intervals.
 * @return {array} Integrated driver and mate phase table.
 */
function _cg_hypotrochoid_motion_table(scale,R,r,d,D,n=720) = _cg_motion_table_from_mid_radii(_cg_hypotrochoid_motion_radii(scale,R,r,d,n),D);
/***
 * @function _cg_hypotrochoid_mate_points_from_driver
 * @brief Generate mate pitch points from driver phase samples.
 * @param scale {number > 0} Curve scale in millimetres.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number >= 0} Pen offset ratio.
 * @param D {number > 0} Fixed centre distance in millimetres.
 * @param n {integer >= 1, default 720} Number of phase intervals.
 * @return {array of points} Conjugate mate pitch points.
 */
function _cg_hypotrochoid_mate_points_from_driver(scale,R,r,d,D,n=720) = _cg_mate_points_from_radius_samples(_cg_hypotrochoid_driver_radii(scale,R,r,d,n),_cg_hypotrochoid_motion_radii(scale,R,r,d,n),D);
/***
 * @function _cg_hypotrochoid_mate_points
 * @brief Return the conjugate mate pitch points for a hypotrochoid.
 * @param scale {number > 0} Curve scale in millimetres.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number >= 0} Pen offset ratio.
 * @param D {number > 0} Fixed centre distance in millimetres.
 * @param n {integer >= 1, default 720} Number of phase intervals.
 * @return {array of points} Conjugate mate pitch points.
 */
function _cg_hypotrochoid_mate_points(scale,R,r,d,D,n=720) = _cg_hypotrochoid_mate_points_from_driver(scale,R,r,d,D,n);

/** @function curve_gear_hypotrochoid_mate
 * @brief Build the standalone conjugate mate for a hypotrochoid driver.
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
    _cg_assert_samples(samples,"hypotrochoid_gear_mate: samples must be an integer >= 120");
    shape=_cg_hypotrochoid_shape(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples);
    mate=_cg_mate_preparation(_cg_sample_polar_radii(shape[1],samples),_cg_sample_polar_radii(shape[1],samples,true),shape[2],shape[3])[2];
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
function curve_gear_hypotrochoid_centre_distance(modul,tooth_number,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=720) = _cg_polar_mate_distance(_cg_hypotrochoid_shape(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples),samples);

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
function curve_gear_hypotrochoid_mate_rotation(modul,tooth_number,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=720,phase=0) = _cg_polar_mate_rotation(_cg_hypotrochoid_shape(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples),samples,phase);
