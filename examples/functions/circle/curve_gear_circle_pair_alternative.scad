/***
 * @function circle_curve_gear_pair_alternative
 * @brief Circle alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/circle/curve_gear_circle_pair_alternative.scad`](functions/circle/curve_gear_circle_pair_alternative.scad)
 * Twelve coarse teeth replace the fine-toothed reference; the bore remains 4.8 mm. Circle has no non-circular shape control; the circular pitch law is deliberately preserved.
 * @image ../images/functions/circle/curve_gear_circle_pair_alternative.png Circle pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_circle_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_circle(pair=true);
