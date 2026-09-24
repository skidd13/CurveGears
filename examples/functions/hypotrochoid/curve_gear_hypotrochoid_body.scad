/***
 * @function hypotrochoid_curve_gear_body
 * @brief Render the Hypotrochoid body before tooth placement.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png curve_gear_hypotrochoid_body example preview
 */
include <../../../src/hypotrochoid/gear.scad>;
$fn=64;
curve_gear_hypotrochoid_body(.8,34,4,4.8,samples=360);
