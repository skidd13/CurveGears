/***
 * @function ellipse_body_alternative
 * @brief Ellipse alternative: The contrasting family controls shown as a body.
 * Source: [`functions/ellipse/curve_gear_ellipse_body_alternative.scad`](functions/ellipse/curve_gear_ellipse_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/ellipse/curve_gear_ellipse_body_alternative.png Ellipse body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_ellipse_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_ellipse(view="body");
