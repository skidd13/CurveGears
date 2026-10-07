/***
 * @function tanh_triad_mate_alternative
 * @brief Tanh Triad alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/tanh_triad/curve_gear_tanh_triad_mate_alternative.scad`](functions/tanh_triad/curve_gear_tanh_triad_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_mate_alternative.png Tanh Triad mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_tanh_triad_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_tanh_triad(view="mate");
