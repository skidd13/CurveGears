/***
 * @function bezier_body_2d_alternative
 * @brief Bézier alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/bezier/curve_gear_bezier_body_alternative_2d.scad`](functions/bezier/curve_gear_bezier_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/bezier/curve_gear_bezier_body_alternative_2d.png Bézier 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_bezier_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_bezier(view="body_2d");
