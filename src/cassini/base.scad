/***
 * @module Cassini
 * @brief Single-loop Cassini oval geometry for non-circular gears.
 *
 * The foci are at `+/-c` and the product of distances to the foci is `b^2`.
 * This family uses only the single-loop branch `0 <= c/b < 1`; the lemniscate
 * and two-loop regimes are intentionally rejected because the common gear
 * pipeline requires one positive, origin-centred polar pitch curve.
 * Reference: https://mathworld.wolfram.com/CassiniOvals.html.
 */
include <../common/curve_gears_math.scad>

/**
 * @function _cg_cassini_focus_ratio_valid
 * @brief Check the supported single-loop Cassini parameter range.
 * @param focus_ratio {0 <= number < 1} Ratio of focal half-distance to the product parameter.
 * @return {boolean} True for the positive single-loop polar branch.
 */
function _cg_cassini_focus_ratio_valid(focus_ratio) = focus_ratio >= 0 && focus_ratio < 1;

/**
 * @function _cg_cassini_unit_radius
 * @brief Evaluate the normalised positive Cassini polar branch.
 * @param focus_ratio {0 <= number < 1} Ratio `c/b`.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Unit Cassini radius.
 */
function _cg_cassini_unit_radius(focus_ratio,theta) =
    sqrt(focus_ratio*focus_ratio*cos(2*theta) +
        sqrt(1-pow(focus_ratio,4)*pow(sin(2*theta),2)));

/**
 * @function _cg_cassini_point
 * @brief Convert a scaled Cassini radius to a Cartesian pitch point.
 * @param scale {number > 0} Curve scale in mm.
 * @param focus_ratio {0 <= number < 1} Ratio `c/b`.
 * @param theta {angle} Polar angle in degrees.
 * @return {array} Cartesian pitch point in mm.
 */
function _cg_cassini_point(scale,focus_ratio,theta) =
    let(r=scale*_cg_cassini_unit_radius(focus_ratio,theta))
    [r*cos(theta),r*sin(theta)];

/**
 * @function _cg_cassini_points
 * @brief Sample one complete single-loop Cassini pitch curve.
 * @param scale {number > 0} Curve scale in mm.
 * @param focus_ratio {0 <= number < 1} Ratio `c/b`.
 * @param n {integer >= 1, default 720} Number of samples.
 * @return {array of points} Closed sampled pitch curve.
 */
function _cg_cassini_points(scale,focus_ratio,n=720) =
    [for(i=[0:n-1]) _cg_cassini_point(scale,focus_ratio,360*i/n)];

/**
 * @function _cg_cassini_scale
 * @brief Scale a Cassini curve to the requested tooth pitch.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param focus_ratio {0 <= number < 1} Ratio `c/b`.
 * @param n {integer >= 1, default 720} Number of perimeter samples.
 * @return {number} Curve scale in mm.
 */
function _cg_cassini_scale(modul,tooth_number,focus_ratio,n=720) =
    _cg_pitch_scale_from_points(modul,tooth_number,_cg_cassini_points(1,focus_ratio,n),_cg_pi);

/**
 * @function _cg_cassini_radius
 * @brief Evaluate a scaled Cassini radius.
 * @param scale {number > 0} Curve scale in mm.
 * @param focus_ratio {0 <= number < 1} Ratio `c/b`.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Cassini radius in mm.
 */
function _cg_cassini_radius(scale,focus_ratio,theta) = scale*_cg_cassini_unit_radius(focus_ratio,theta);

/**
 * @function _cg_cassini_max_radius
 * @brief Calculate the exact maximum scaled radius on the supported branch.
 * @param scale {number > 0} Curve scale in mm.
 * @param focus_ratio {0 <= number < 1} Ratio `c/b`.
 * @param n {integer >= 1, default 1440} Retained for internal call compatibility; the exact maximum needs no sampling.
 * @return {number} Maximum radius in mm.
 */
// On the supported q<1 branch, squared radius increases with cos(2*theta); its maximum is at theta=0.
function _cg_cassini_max_radius(scale,focus_ratio,n=1440) =
    scale*sqrt(1+focus_ratio*focus_ratio);
