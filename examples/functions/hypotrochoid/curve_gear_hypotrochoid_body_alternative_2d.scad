/***
 * @function hypotrochoid_body_2d_alternative
 * @brief Hypotrochoid alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative_2d.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative_2d.png Hypotrochoid 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_hypotrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_hypotrochoid(view="body_2d");
