/***
 * @function pascal_body_alternative
 * @brief Pascal alternative: The contrasting family controls shown as a body.
 * Source: [`functions/pascal/curve_gear_pascal_body_alternative.scad`](functions/pascal/curve_gear_pascal_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/pascal/curve_gear_pascal_body_alternative.png Pascal body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_pascal_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_pascal(view="body");
