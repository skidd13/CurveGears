/***
 * @function superformula_body_alternative
 * @brief Superformula alternative: The contrasting family controls shown as a body.
 * Source: [`functions/superformula/curve_gear_superformula_body_alternative.scad`](functions/superformula/curve_gear_superformula_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/superformula/curve_gear_superformula_body_alternative.png Superformula body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_superformula_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_superformula(view="body");
