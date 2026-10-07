/***
 * @function logistic_dwell_body_alternative
 * @brief Logistic Dwell alternative: The contrasting family controls shown as a body.
 * Source: [`functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative.scad`](functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_body_alternative.png Logistic Dwell body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_logistic_dwell_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_logistic_dwell(view="body");
