include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/**
 * @function _cg_epitrochoid_motion_radii
 * @brief Evaluate epitrochoid radii at integration midpoints.
 * @param scale {number > 0} Overall curve scale.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number > 0} Pen offset ratio.
 * @param n {integer >= 1, default 240} Number of midpoint samples.
 * @return {array of number} Sampled radii in angular order.
 */
function _cg_epitrochoid_motion_radii(scale,R,r,d,n=240) = [for(i=[0:n-1]) _cg_epitrochoid_curve_radius(scale,R,r,d,360*(i+.5)/n)];
/** @function _cg_epitrochoid_driver_radii
 * @brief Evaluate epitrochoid radii at direct mate-construction angles.
 */
function _cg_epitrochoid_driver_radii(scale,R,r,d,n=240) = [for(i=[0:n-1]) _cg_epitrochoid_curve_radius(scale,R,r,d,360*i/n)];
/**
 * @function _cg_epitrochoid_centre_distance
 * @brief Solve the epitrochoid conjugate centre distance.
 * @param scale {number > 0} Overall curve scale.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number > 0} Pen offset ratio.
 * @return {number} Conjugate centre distance.
 */
function _cg_epitrochoid_centre_distance(scale,R,r,d,n=240) =
    let(points=_cg_epitrochoid_points_scaled(scale,R,r,d,720),mx=max([for(p=points) _cg_vlen(p)]))
    _cg_solve_mate_distance(_cg_epitrochoid_motion_radii(scale,R,r,d,n),mx+0.01,4*mx);
/**
 * @function _cg_epitrochoid_motion_table
 * @brief Build the shared epitrochoid phase-motion table.
 * @param scale {number > 0} Overall curve scale.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number > 0} Pen offset ratio.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array} Monotonic driver-to-mate phase-motion table.
 */
function _cg_epitrochoid_motion_table(scale,R,r,d,D,n=360) = _cg_motion_table_from_mid_radii(_cg_epitrochoid_motion_radii(scale,R,r,d,n),D);
/**
 * @function _cg_epitrochoid_mate_points_from_driver
 * @brief Build epitrochoid mate pitch points by advancing driver angle directly.
 * @param scale {number > 0} Overall curve scale.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number > 0} Pen offset ratio.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param motion {array} Shared driver-to-mate phase-motion table.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_epitrochoid_mate_points_from_driver(scale,R,r,d,D,n=360) =
    _cg_mate_points_from_radius_samples(_cg_epitrochoid_driver_radii(scale,R,r,d,n),_cg_epitrochoid_motion_radii(scale,R,r,d,n),D);
/**
 * @function _cg_epitrochoid_mate_points
 * @brief Build epitrochoid mate pitch points and their shared motion table.
 * @param scale {number > 0} Overall curve scale.
 * @param R {number > 0} Fixed-circle radius ratio.
 * @param r {number > 0} Rolling-circle radius ratio.
 * @param d {number > 0} Pen offset ratio.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_epitrochoid_mate_points(scale,R,r,d,D,n=360) = _cg_epitrochoid_mate_points_from_driver(scale,R,r,d,D,n);

/***
 * @function curve_gear_epitrochoid_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone epitrochoid mate boundary at the origin.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_mate.png Epitrochoid mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 */
module curve_gear_epitrochoid_mate(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    assert(samples >= 120 && floor(samples)==samples,"epitrochoid_gear_mate: samples must be an integer >= 120");
    scale=_cg_epitrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples);
    D=_cg_epitrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio,samples);
    mate=_cg_epitrochoid_mate_points(scale,major_ratio,rolling_ratio,offset_ratio,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/***
 * @function curve_gear_epitrochoid_centre_distance(modul, tooth_number, major_ratio, rolling_ratio, offset_ratio, ...)
 * @brief Return the mathematical centre distance for an epitrochoid pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_epitrochoid_centre_distance(modul,tooth_number,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=720) = let(scale=_cg_epitrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples)) _cg_epitrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio,samples);

/***
 * @function curve_gear_epitrochoid_mate_rotation(modul, tooth_number, major_ratio, rolling_ratio, offset_ratio, ...)
 * @brief Return the conjugate epitrochoid mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param samples {integer >= 120, default 720} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_epitrochoid_mate_rotation(modul,tooth_number,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=720,phase=0) = let(scale=_cg_epitrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples),D=_cg_epitrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio,samples),motion=_cg_epitrochoid_motion_table(scale,major_ratio,rolling_ratio,offset_ratio,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
