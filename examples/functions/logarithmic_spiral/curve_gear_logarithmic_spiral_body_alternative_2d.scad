/***
 * @function logarithmic_spiral_body_2d_alternative
 * @brief Logarithmic spiral alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_alternative_2d.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_alternative_2d.png Logarithmic spiral 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_logarithmic_spiral_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_logarithmic_spiral(view="body_2d");
