/***
 * @function logistic_dwell_curve_gear_alternative
 * @brief Logistic Dwell alternative: Depth 0.46 and gain 3 replace the canonical shallow, steep logistic gate. The larger radial variation and smoother transitions distinguish curve amplitude from gate sharpness; coarse teeth expose the contour.
 * Source: [`functions/logistic_dwell/curve_gear_logistic_dwell_alternative.scad`](functions/logistic_dwell/curve_gear_logistic_dwell_alternative.scad)
 * Depth 0.46 and gain 3 replace the canonical shallow, steep logistic gate. The larger radial variation and smoother transitions distinguish curve amplitude from gate sharpness; coarse teeth expose the contour.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_alternative.png Logistic Dwell gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/logistic_dwell/gear.scad>;
include <../../../src/logistic_dwell/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_logistic_dwell(pair=false) {
    if (pair)
        curve_gear_logistic_dwell_pair(1.2,20,2,4.8,gain=3,depth=.46,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_logistic_dwell(1.2,20,2,4.8,gain=3,depth=.46,samples=360);
}
_alternative_example_logistic_dwell();
