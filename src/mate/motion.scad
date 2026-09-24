/***
 * @module Mate motion
 * @brief Shared phase interpolation for mathematically conjugate mates.
 *
 * Family files own radius and pitch-point equations. This file owns the
 * shared midpoint integration, closure solve, direct mate-point construction
 * and phase interpretation used by every dynamically conjugate family.
 *
 * The fixed-centre conjugate pitch relation is `r2=D-r1` with rolling law
 * `dphi/dtheta=r1/(D-r1)`. Shape-driven families provide `r1(theta)` or an
 * adapted closed pitch curve; a future motion-driven adapter may instead
 * derive both radii from a displacement law before entering this same core.
 * These equations define pitch geometry, not exact tooth-flank geometry.
 */
include <../common/common_math.scad>

/***
 * @function _cg_motion_values_from_mid_radii(mid_radii, D)
 * @brief Integrate one revolution from midpoint radii at a candidate centre distance.
 * @param mid_radii {array} Driver radii sampled at integration midpoints.
 * @param D {number > 0} Candidate centre distance in mm.
 * @return {array} Incremental mate-angle values in degrees.
 */
function _cg_motion_values_from_mid_radii(mid_radii,D) =
    [for(i=[0:len(mid_radii)-1])
        let(step=360/len(mid_radii),r=mid_radii[i]) step*r/(D-r)];

/***
 * @function _cg_motion_table_from_mid_radii(mid_radii, D)
 * @brief Build a phase-to-phase motion table from midpoint radii.
 * @param mid_radii {array} Driver radii sampled at integration midpoints.
 * @param D {number > 0} Centre distance in mm.
 * @return {array} Table of `[driver phase, mate phase]` pairs in degrees.
 */
function _cg_motion_table_from_mid_radii(mid_radii,D) =
    let(values=_cg_motion_values_from_mid_radii(mid_radii,D),cumulative=_cg_prefix_sums(values),n=len(mid_radii))
    [for(i=[0:n]) [360*i/n,cumulative[i]]];

/***
 * @function _cg_motion_closure_error_from_mid_radii(mid_radii, D)
 * @brief Return the one-turn closure error for midpoint-radius integration.
 * @param mid_radii {array} Driver radii sampled at integration midpoints.
 * @param D {number > 0} Candidate centre distance in mm.
 * @return {number} Closure error in degrees.
 */
function _cg_motion_closure_error_from_mid_radii(mid_radii,D) =
    _cg_sum(_cg_motion_values_from_mid_radii(mid_radii,D))-360;

/**
 * @function _cg_motion_table_from_radius_samples
 * @brief Integrate the rolling law at driver-angle samples.
 * @param driver_radii {array of number} Driver radii at output angles.
 * @param mid_radii {array of number} Driver radii at interval midpoints.
 * @param D {number > 0} Centre distance in mm.
 * @return {array} Table of `[driver phase, mate phase]` pairs in degrees.
 *
 * The midpoint radii are used only for integration.  The table is therefore
 * an output of the direct driver-angle integration, not an inverse-motion
 * reconstruction of the mate.
 */
function _cg_motion_table_from_radius_samples(driver_radii,mid_radii,D) =
    let(values=_cg_motion_values_from_mid_radii(mid_radii,D),cumulative=_cg_prefix_sums(values),n=len(driver_radii))
    [for(i=[0:n]) [360*i/n,cumulative[i]]];

/***
 * @function _cg_solve_mate_distance(mid_radii, lo, hi)
 * @brief Solve the centre distance whose integrated mate motion closes after one turn.
 * @param mid_radii {array} Driver radii sampled at integration midpoints.
 * @param lo {number > 0} Lower centre-distance bracket in mm.
 * @param hi {number > 0} Upper centre-distance bracket in mm.
 * @param i {integer, default 0} Recursive bisection iteration.
 * @return {number} Solved centre distance in mm.
 */
function _cg_solve_mate_distance(mid_radii,lo,hi,i=0) =
    i>=36 ? (lo+hi)/2 :
    let(mid=(lo+hi)/2,e=_cg_motion_closure_error_from_mid_radii(mid_radii,mid))
        e>0 ? _cg_solve_mate_distance(mid_radii,mid,hi,i+1)
        : _cg_solve_mate_distance(mid_radii,lo,mid,i+1);

/**
 * @function _cg_mate_points_from_radius_samples
 * @brief Construct mate pitch points directly while advancing driver angle.
 * @param driver_radii {array of number} Driver radii at output angles.
 * @param mid_radii {array of number} Driver radii at interval midpoints.
 * @param D {number > 0} Centre distance in mm.
 * @return {array of points} Directly generated Cartesian mate pitch points.
 *
 * For each driver sample `theta_i`, the accumulated rolling angle `phi_i`
 * is evaluated first and the mate radius is then `D-driver_radii[i]`.
 * This is the primary mate-construction path for all radial families.
 */
function _cg_mate_points_from_radius_samples(driver_radii,mid_radii,D) =
    let(values=_cg_motion_values_from_mid_radii(mid_radii,D),cumulative=_cg_prefix_sums(values),n=len(driver_radii))
    [for(i=[0:n-1]) _cg_mate_point_from_radius(driver_radii[i],D,cumulative[i])];

/***
 * @function _cg_mate_point_from_radius(radius, D, phi)
 * @brief Map a driver phase and evaluated driver radius to its opposed mate pitch point.
 * @param radius {number > 0} Driver radius in mm.
 * @param D {number > 0} Centre distance in mm.
 * @param phi {angle} Mate polar angle in degrees.
 * @return {array} Mate Cartesian pitch point in mm.
 */
function _cg_mate_point_from_radius(radius,D,phi) =
    let(mate_radius=D-radius)
    [mate_radius*cos(phi),mate_radius*sin(phi)];

/***
 * @function _cg_motion_y_unwrapped(tab, angle)
 * @brief Return the continuous mate angle for a driver angle from a motion table.
 * @param tab {array} Table of `[driver phase, mate phase]` pairs.
 * @param angle {angle} Driver phase in degrees.
 * @return {angle} Continuous mate phase in degrees.
 */
function _cg_motion_y_unwrapped(tab,angle) =
    let(turns=floor(angle/360),wrapped=angle-360*turns)
    360*turns + _cg_interp_y_for_x(tab,wrapped);

/***
 * @function _cg_mate_rotation_for_phase(tab, phase)
 * @brief Convert a motion-table phase into the mate display rotation.
 * @param tab {array} Table of `[driver phase, mate phase]` pairs.
 * @param phase {angle} Driver phase in degrees.
 * @return {angle} Mate display rotation in degrees.
 */
function _cg_mate_rotation_for_phase(tab,phase) = 180 - _cg_motion_y_unwrapped(tab,phase);
