/***
 * @function logistic_dwell_curve_gear_pair_alternative
 * @brief Logistic Dwell alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/logistic_dwell/curve_gear_logistic_dwell_pair_alternative.scad`](functions/logistic_dwell/curve_gear_logistic_dwell_pair_alternative.scad)
 * Depth 0.46 and gain 3 replace the canonical shallow, steep logistic gate. The larger radial variation and smoother transitions distinguish curve amplitude from gate sharpness; coarse teeth expose the contour.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_pair_alternative.png Logistic Dwell pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_logistic_dwell_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_logistic_dwell(pair=true);
