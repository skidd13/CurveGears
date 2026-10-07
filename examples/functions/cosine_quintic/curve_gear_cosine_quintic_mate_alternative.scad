/***
 * @function cosine_quintic_mate_alternative
 * @brief Cosine Quintic alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/cosine_quintic/curve_gear_cosine_quintic_mate_alternative.scad`](functions/cosine_quintic/curve_gear_cosine_quintic_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate_alternative.png Cosine Quintic mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cosine_quintic_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_cosine_quintic(view="mate");
