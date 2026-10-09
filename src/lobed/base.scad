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
include <../common/harmonic.scad>

/***
 * @function _cg_lobed_unit_radius
 * @brief Evaluate the unit radial modulation r=s(1+d cos(kθ)) of a harmonic lobed pitch curve, whose teeth are placed by arc length.
 * @param lobes {integer >= 1} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1} Radial modulation depth.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Unit radius at the requested angle.
 */
function _cg_lobed_unit_radius(lobes,lobe_depth,theta) = _cg_harmonic_unit_radius([[lobes,lobe_depth,0]],theta);
function _cg_lobed_shape(modul,tooth_number,lobes,lobe_depth,samples=720) =
    _cg_polar_shape(
        function(theta) _cg_lobed_unit_radius(lobes,lobe_depth,theta),
        modul,tooth_number,samples,
        function(scale) [scale*(1+lobe_depth)+.01,3*scale]);
