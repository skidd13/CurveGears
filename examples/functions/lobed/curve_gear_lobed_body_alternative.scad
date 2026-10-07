/***
 * @function lobed_body_alternative
 * @brief Lobed alternative: The contrasting family controls shown as a body.
 * Source: [`functions/lobed/curve_gear_lobed_body_alternative.scad`](functions/lobed/curve_gear_lobed_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/lobed/curve_gear_lobed_body_alternative.png Lobed body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_lobed_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_lobed(view="body");
