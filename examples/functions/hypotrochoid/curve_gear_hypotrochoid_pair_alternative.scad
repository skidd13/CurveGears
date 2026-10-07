/***
 * @function hypotrochoid_curve_gear_pair_alternative
 * @brief Hypotrochoid alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad)
 * A 5:1 rolling ratio and offset 0.35 produce five-fold shaping rather than the canonical three-fold outline. The alternative changes the curve itself, not merely the pair spacing.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.png Hypotrochoid pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_hypotrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_hypotrochoid(pair=true);
