/***
 * @function ellipse_curve_gear_body
 * @brief Render the Ellipse body before tooth placement.
 * Source: [`functions/ellipse/curve_gear_ellipse_body.scad`](functions/ellipse/curve_gear_ellipse_body.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse_body.png curve_gear_ellipse_body example preview
 */
include <../../../src/ellipse/mate.scad>;
$fn=64;
curve_gear_ellipse_body(.8,34,4,4.8,eccentricity=.72,samples=240);
