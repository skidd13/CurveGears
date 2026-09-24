/***
 * @function bezier_curve_gear_body
 * @brief Render the Bézier body before tooth placement.
 * Source: [`functions/bezier/curve_gear_bezier_body.scad`](functions/bezier/curve_gear_bezier_body.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_body.png curve_gear_bezier_body example preview
 */
include <../../../src/bezier/base.scad>;
$fn=64;
curve_gear_bezier_body(.8,34,4,4.8,samples=240);
