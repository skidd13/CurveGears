/***
 * @module Mate preparation
 * @brief Prepare conjugate pitch geometry from explicitly sampled physical radii.
 *
 * Families own their radius laws, sampling and distance bounds. This layer
 * composes the existing solver and integration once per invocation.
 */
include <motion.scad>

/**
 * @function _cg_mate_radii_valid
 * @brief Check finite positive physical radii without building geometry.
 * @param radii {array of number} Boundary or midpoint radii in millimetres.
 * @return {boolean} True for at least three finite positive radii.
 */
function _cg_mate_radii_valid(radii) = len(radii)>=3
    && min([for(r=radii) is_num(r) && r>0 && r<1e100 ? 1 : 0])==1;

/**
 * @function _cg_mate_distance_from_radii
 * @brief Solve the existing rolling equation after checking its physical bracket.
 * @param mid_radii {array of number} Physical radii at integration midpoints.
 * @param lower {number or function} Lower distance bound strictly above the midpoint radii.
 * @param upper {number} Upper distance bound enclosing one-turn closure.
 * @return {number} Solved centre distance in millimetres.
 */
function _cg_mate_distance_from_radii(mid_radii,lower,upper) =
    let(bound=is_function(lower) ? lower(mid_radii) : lower)
    assert(_cg_mate_radii_valid(mid_radii),"mate_preparation: midpoint radii must be finite and positive")
    assert(is_num(bound) && is_num(upper) && bound>max(mid_radii) && upper>bound && upper<1e100,
        "mate_preparation: distance bounds must be finite and outside the driver")
    assert(_cg_motion_closure_error_from_mid_radii(mid_radii,bound)>=0
        && _cg_motion_closure_error_from_mid_radii(mid_radii,upper)<=0,
        "mate_preparation: distance bounds must bracket one-turn closure")
    _cg_solve_mate_distance(mid_radii,bound,upper);

/**
 * @function _cg_mate_preparation
 * @brief Share distance, motion integration and conjugate pitch construction.
 * @param driver_radii {array of number} Radii at output angle boundaries.
 * @param mid_radii {array of number} Radii at the corresponding interval midpoints.
 * @param lower {number, function or undef} Family-selected lower solver bound.
 * @param upper {number or undef} Family-selected upper solver bound.
 * @param distance {number or undef} Optional already solved centre distance.
 * @return {array} `[distance, motion table, mate pitch points]`, consumed by shared geometry operators.
 */
function _cg_mate_preparation(driver_radii,mid_radii,lower=undef,upper=undef,distance=undef) =
    assert(len(driver_radii)==len(mid_radii) && _cg_mate_radii_valid(driver_radii) && _cg_mate_radii_valid(mid_radii),
        "mate_preparation: boundary and midpoint radii must be finite, positive and equally sized")
    let(D=is_undef(distance) ? _cg_mate_distance_from_radii(mid_radii,lower,upper) : distance)
    assert(is_num(D) && D<1e100 && D>max(concat(driver_radii,mid_radii)),
        "mate_preparation: centre distance must exceed all driver radii")
    let(state=_cg_motion_integration_state(driver_radii,mid_radii,D))
    [D,state[2],_cg_mate_points_from_radius_samples_with_state(driver_radii,D,state)];

/**
 * @function _cg_polar_mate_distance
 * @brief Solve one named shape's physical centre distance without building unused geometry.
 * @param shape {array} `[driver points, radius function, lower bound, upper bound, radial root]`.
 * @param n {integer >= 3} Number of motion intervals.
 * @return {number} Centre distance in millimetres.
 */
function _cg_polar_mate_distance(shape,n) =
    _cg_mate_distance_from_radii(_cg_sample_polar_radii(shape[1],n,true),shape[2],shape[3]);

/**
 * @function _cg_polar_mate_rotation
 * @brief Solve distance and integrated rolling motion for a named shape and phase.
 * @param shape {array} Physical shape and bound descriptor.
 * @param n {integer >= 3} Number of motion intervals.
 * @param phase {angle} Unwrapped driver phase in degrees.
 * @return {angle} Mate display rotation in degrees.
 */
function _cg_polar_mate_rotation(shape,n,phase) =
    let(mid=_cg_sample_polar_radii(shape[1],n,true),D=_cg_mate_distance_from_radii(mid,shape[2],shape[3]),motion=_cg_motion_table_from_mid_radii(mid,D))
    _cg_mate_rotation_for_phase(motion,phase);
