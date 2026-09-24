/***
 * @module Ellipse
 * @brief Ellipse-based non-circular gear geometry.
 *
 * The centred pitch curve is `x=a cos(theta)`, `y=b sin(theta)`, or
 * `r=ab/sqrt(b^2 cos^2(theta)+a^2 sin^2(theta))` in polar form. Eccentricity
 * zero is circular; increasing eccentricity increases the varying transmission
 * ratio. The public gear, mate and pair APIs consume these primitives.
 * Reference: https://mathworld.wolfram.com/Ellipse.html.
 */
include <../common/curve_gears_math.scad>

// Centred ellipse: r=ab/sqrt(b² cos²θ+a² sin²θ); Ramanujan perimeter approximation.
/***
 * @function _cg_ellipse_axes(modul, tooth_number, eccentricity)
 * @brief Calculate the ellipse semi-axes for a requested module and tooth count.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1} Ellipse eccentricity.
 * @return {array} Semi-major and semi-minor axes as `[a, b]` in mm.
 */
function _cg_ellipse_axes(modul,tooth_number,eccentricity) =
    let(
        ratio=sqrt(1-eccentricity*eccentricity),
        h=pow((1-ratio)/(1+ratio),2),
        unit_perimeter=_cg_pi*(1+ratio)*(1+3*h/(10+sqrt(4-3*h))),
        a=(_cg_pi*modul*tooth_number)/unit_perimeter
    )
    [a,a*ratio];

/***
 * @function _cg_ellipse_radius(a, b, theta)
 * @brief Evaluate the ellipse radius at an angular position.
 * @param a {number > 0} Ellipse semi-major axis in mm.
 * @param b {number > 0} Ellipse semi-minor axis in mm.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Radius in mm.
 */
function _cg_ellipse_radius(a,b,theta) = a*b/sqrt(pow(b*cos(theta),2)+pow(a*sin(theta),2));
/***
 * @function _cg_ellipse_driver_point(a, b, theta)
 * @brief Convert an ellipse radius and angle into a Cartesian pitch point.
 * @param a {number > 0} Ellipse semi-major axis in mm.
 * @param b {number > 0} Ellipse semi-minor axis in mm.
 * @param theta {angle} Polar angle in degrees.
 * @return {array} Cartesian point `[x, y]` in mm.
 */
function _cg_ellipse_driver_point(a,b,theta) = let(r=_cg_ellipse_radius(a,b,theta)) [r*cos(theta),r*sin(theta)];
