/***
 * @function cosine_quintic_body_2d_alternative
 * @brief Cosine Quintic alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative_2d.scad`](functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_alternative_2d.png Cosine Quintic 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_cosine_quintic_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_cosine_quintic(view="body_2d");
