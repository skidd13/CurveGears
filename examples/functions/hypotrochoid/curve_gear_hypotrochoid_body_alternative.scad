/***
 * @function hypotrochoid_body_alternative
 * @brief Hypotrochoid alternative: The contrasting family controls shown as a body.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative.png Hypotrochoid body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_hypotrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_hypotrochoid(view="body");
