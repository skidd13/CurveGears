/***
 * @function lobed_mate_alternative
 * @brief Lobed alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/lobed/curve_gear_lobed_mate_alternative.scad`](functions/lobed/curve_gear_lobed_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/lobed/curve_gear_lobed_mate_alternative.png Lobed mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_lobed_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_lobed(view="mate");
