/***
 * @function bezier_curve_gear_pair
 * @brief Render a complete Bézier gear pair with derived conjugate motion.
 * Source: [`functions/bezier/curve_gear_bezier_pair.scad`](functions/bezier/curve_gear_bezier_pair.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_pair.png curve_gear_bezier_pair example preview
 */
include <../../../src/bezier/pair.scad>;
$fn=64;
curve_gear_bezier_pair(.8,34,4,4.8,samples=240,together_built=false);
