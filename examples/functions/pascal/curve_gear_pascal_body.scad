/***
 * @function pascal_curve_gear_body
 * @brief Render the Pascal body before tooth placement.
 * Source: [`functions/pascal/curve_gear_pascal_body.scad`](functions/pascal/curve_gear_pascal_body.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_body.png curve_gear_pascal_body example preview
 */
include <../../../src/pascal/mate.scad>;
$fn=64;
curve_gear_pascal_body(.8,34,4,4.8,eccentricity=.35,samples=240);
