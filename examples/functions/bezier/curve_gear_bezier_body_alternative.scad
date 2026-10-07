/***
 * @function bezier_body_alternative
 * @brief Bézier alternative: The contrasting family controls shown as a body.
 * Source: [`functions/bezier/curve_gear_bezier_body_alternative.scad`](functions/bezier/curve_gear_bezier_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/bezier/curve_gear_bezier_body_alternative.png Bézier body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_bezier_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_bezier(view="body");
