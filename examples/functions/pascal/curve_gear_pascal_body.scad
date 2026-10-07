/***
 * @function pascal_curve_gear_body
 * @brief Render the Pascal body before tooth placement.
 * Source: [`functions/pascal/curve_gear_pascal_body.scad`](functions/pascal/curve_gear_pascal_body.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_body.png curve_gear_pascal_body example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/pascal/mate.scad>;
include <../../palette.scad>;
$fn=64;
color(example_driver_color)
curve_gear_pascal_body(.8,34,4,4.8,eccentricity=.60,samples=240);
