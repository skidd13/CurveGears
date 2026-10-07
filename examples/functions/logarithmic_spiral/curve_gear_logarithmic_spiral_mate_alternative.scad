/***
 * @function logarithmic_spiral_mate_alternative
 * @brief Logarithmic spiral alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate_alternative.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate_alternative.png Logarithmic spiral mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_logarithmic_spiral_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_logarithmic_spiral(view="mate");
