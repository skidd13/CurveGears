/***
 * @function epitrochoid_mate_alternative
 * @brief Epitrochoid alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_mate_alternative.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_mate_alternative.png Epitrochoid mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_epitrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_epitrochoid(view="mate");
