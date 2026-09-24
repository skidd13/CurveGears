/***
 * @function bezier_curve_gear
 * @brief Render a Bézier gear from the documented pitch-curve family.
 * Source: [`functions/bezier/curve_gear_bezier.scad`](functions/bezier/curve_gear_bezier.scad)
 * @image ../images/functions/bezier/curve_gear_bezier.png curve_gear_bezier example preview
 */
include <../../../src/bezier/base.scad>;
$fn=64;
curve_gear_bezier(.8,34,4,4.8,samples=240);
