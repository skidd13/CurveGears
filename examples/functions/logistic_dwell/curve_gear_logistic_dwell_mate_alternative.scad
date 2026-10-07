/***
 * @function logistic_dwell_mate_alternative
 * @brief Logistic Dwell alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.scad`](functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.png Logistic Dwell mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_logistic_dwell_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_logistic_dwell(view="mate");
