/***
 * @module Trochoid common
 * @brief Private shared geometry for rolling-circle trochoid families.
 *
 * This file is an implementation detail. Public family APIs live in
 * `epitrochoid/` and `hypotrochoid/`; the rolling equations remain in those
 * family modules. This layer contains only the shared curve post-processing.
 */
include <../common/curve_gears_math.scad>

/** @function _cg_trochoid_scale_from_points
 * @brief Scale a sampled unit curve to the requested tooth pitch.
 */
function _cg_trochoid_scale_from_points(modul,tooth_number,points) =
    _cg_pitch_scale_from_points(modul,tooth_number,points,_cg_circle_pi);

/** @function _cg_trochoid_radius_from_point
 * @brief Evaluate the radial distance of a unit-curve point.
 */
function _cg_trochoid_radius_from_point(point) = _cg_vlen(point);
/** @function _cg_trochoid_curve_radius_from_point
 * @brief Evaluate the radial distance of a scaled curve point.
 */
function _cg_trochoid_curve_radius_from_point(scale,point) = scale*_cg_trochoid_radius_from_point(point);
/** @function _cg_trochoid_points_scaled_from_points
 * @brief Scale sampled unit-curve points.
 */
function _cg_trochoid_points_scaled_from_points(scale,points) = _cg_scale_points(scale,points);
