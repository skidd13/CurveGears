/***
 * @module Lobed
 * @brief Harmonic lobed non-circular gear geometry.
 *
 * The pitch radius is `r(theta)=s(1+d cos(k theta))`; `k` controls the lobe
 * count and `d` the radial modulation. Deep modulation can reduce tooth
 * accessibility. The public gear, mate and pair APIs consume these primitives.
 * Reference: https://mathworld.wolfram.com/FourierSeries.html.
 */
include <../common/curve_gears_math.scad>

// Harmonic polar curve: r=s(1+d cos(kθ)); arc-length tooth placement.
/***
 * @function _cg_lobed_unit_radius(lobes, lobe_depth, theta)
 * @brief Evaluate the unit radial modulation of a lobed pitch curve.
 * @param lobes {integer >= 1} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1} Radial modulation depth.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Unit radius at the requested angle.
 */
function _cg_lobed_unit_radius(lobes,lobe_depth,theta) = 1+lobe_depth*cos(lobes*theta);
/***
 * @function _cg_lobed_point(scale, lobes, lobe_depth, theta)
 * @brief Evaluate one Cartesian point on a scaled lobed pitch curve.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param lobes {integer >= 1} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1} Radial modulation depth.
 * @param theta {angle} Polar angle in degrees.
 * @return {array} Cartesian point `[x, y]` in mm.
 */
function _cg_lobed_point(scale,lobes,lobe_depth,theta) = let(r=scale*_cg_lobed_unit_radius(lobes,lobe_depth,theta)) [r*cos(theta),r*sin(theta)];
/***
 * @function _cg_lobed_unit_points(lobes, lobe_depth, n)
 * @brief Sample one complete unit lobed pitch curve.
 * @param lobes {integer >= 1} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1} Radial modulation depth.
 * @param n {integer >= 1, default 720} Number of samples.
 * @return {array} Closed list of sampled Cartesian points.
 */
function _cg_lobed_unit_points(lobes,lobe_depth,n=720) = [for(i=[0:n-1]) _cg_lobed_point(1,lobes,lobe_depth,360*i/n)];
/***
 * @function _cg_lobed_scale(modul, tooth_number, lobes, lobe_depth, n)
 * @brief Scale a unit lobed curve to the requested tooth pitch.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param lobes {integer >= 1} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1} Radial modulation depth.
 * @param n {integer >= 1, default 720} Number of samples used for arc length.
 * @return {number} Mean pitch-radius scale in mm.
 */
function _cg_lobed_scale(modul,tooth_number,lobes,lobe_depth,n=720) =
    _cg_pitch_scale_from_points(modul,tooth_number,_cg_lobed_unit_points(lobes,lobe_depth,n),_cg_pi);
/***
 * @function _cg_lobed_radius(scale, lobes, lobe_depth, theta)
 * @brief Evaluate a scaled lobed pitch-curve radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param lobes {integer >= 1} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1} Radial modulation depth.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Radius in mm.
 */
function _cg_lobed_radius(scale,lobes,lobe_depth,theta) = scale*_cg_lobed_unit_radius(lobes,lobe_depth,theta);
