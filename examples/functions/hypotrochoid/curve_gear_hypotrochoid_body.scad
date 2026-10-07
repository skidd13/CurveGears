/***
 * @function hypotrochoid_curve_gear_body
 * @brief Render the Hypotrochoid body before tooth placement.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png curve_gear_hypotrochoid_body example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/hypotrochoid/gear.scad>;
include <../../palette.scad>;
$fn=64;
color(example_driver_color)
curve_gear_hypotrochoid_body(.8,34,4,4.8,samples=360);
