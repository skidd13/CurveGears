/***
 * @function epitrochoid_curve_gear_pair_alternative
 * @brief Epitrochoid alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_pair_alternative.scad`](functions/epitrochoid/curve_gear_epitrochoid_pair_alternative.scad)
 * A rolling ratio of 2:1 produces broad two-fold shaping instead of the canonical four-fold scallops. Offset 0.65 strengthens the excursions of the generating point.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_pair_alternative.png Epitrochoid pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_epitrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_epitrochoid(pair=true);
