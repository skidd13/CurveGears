/***
 * @function cusp_body_alternative
 * @brief Cusp alternative: The contrasting family controls shown as a body.
 * Source: [`functions/cusp/curve_gear_cusp_body_alternative.scad`](functions/cusp/curve_gear_cusp_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/cusp/curve_gear_cusp_body_alternative.png Cusp body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cusp_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_cusp(view="body");
