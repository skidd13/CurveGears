/***
 * @function bezier_curve_gear_mate
 * @brief Render the conjugate Bézier mate generated from the driver pitch curve.
 * Source: [`functions/bezier/curve_gear_bezier_mate.scad`](functions/bezier/curve_gear_bezier_mate.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_mate.png curve_gear_bezier_mate example preview
 */
include <../../../src/bezier/mate.scad>;
$fn=64;
curve_gear_bezier_mate(.8,34,4,4.8,samples=240);
