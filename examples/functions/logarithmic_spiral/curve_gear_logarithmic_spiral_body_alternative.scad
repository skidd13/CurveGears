/***
 * @function logarithmic_spiral_body_alternative
 * @brief Logarithmic spiral alternative: The contrasting family controls shown as a body.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_alternative.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_alternative.png Logarithmic spiral body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_logarithmic_spiral_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_logarithmic_spiral(view="body");
