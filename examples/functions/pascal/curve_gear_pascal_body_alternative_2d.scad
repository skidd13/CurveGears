/***
 * @function pascal_body_2d_alternative
 * @brief Pascal alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/pascal/curve_gear_pascal_body_alternative_2d.scad`](functions/pascal/curve_gear_pascal_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/pascal/curve_gear_pascal_body_alternative_2d.png Pascal 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_pascal_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_pascal(view="body_2d");
