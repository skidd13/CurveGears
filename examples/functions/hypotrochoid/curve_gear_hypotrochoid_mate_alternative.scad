/***
 * @function hypotrochoid_mate_alternative
 * @brief Hypotrochoid alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_mate_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_mate_alternative.png Hypotrochoid mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_hypotrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_hypotrochoid(view="mate");
