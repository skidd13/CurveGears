/***
 * @function tanh_triad_body_alternative
 * @brief Tanh Triad alternative: The contrasting family controls shown as a body.
 * Source: [`functions/tanh_triad/curve_gear_tanh_triad_body_alternative.scad`](functions/tanh_triad/curve_gear_tanh_triad_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_body_alternative.png Tanh Triad body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_tanh_triad_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_tanh_triad(view="body");
