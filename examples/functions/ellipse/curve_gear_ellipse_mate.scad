/***
 * @function ellipse_curve_gear_mate
 * @brief Render the conjugate Ellipse mate generated from the driver pitch curve.
 * Source: [`functions/ellipse/curve_gear_ellipse_mate.scad`](functions/ellipse/curve_gear_ellipse_mate.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse_mate.png curve_gear_ellipse_mate example preview
 */
include <../../../src/ellipse/mate.scad>;
$fn=64;
curve_gear_ellipse_mate(.8,34,4,4.8,eccentricity=.72,samples=240);
