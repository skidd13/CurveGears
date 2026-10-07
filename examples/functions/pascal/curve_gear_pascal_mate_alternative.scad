/***
 * @function pascal_mate_alternative
 * @brief Pascal alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/pascal/curve_gear_pascal_mate_alternative.scad`](functions/pascal/curve_gear_pascal_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/pascal/curve_gear_pascal_mate_alternative.png Pascal mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_pascal_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_pascal(view="mate");
