/***
 * @function superformula_mate_alternative
 * @brief Superformula alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/superformula/curve_gear_superformula_mate_alternative.scad`](functions/superformula/curve_gear_superformula_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/superformula/curve_gear_superformula_mate_alternative.png Superformula mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_superformula_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_superformula(view="mate");
