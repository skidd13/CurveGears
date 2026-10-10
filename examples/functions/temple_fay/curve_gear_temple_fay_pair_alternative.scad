/***
 * @function temple_fay_curve_gear_pair_alternative
 * @brief Temple Fay alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_pair_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_pair_alternative.scad)
 * This pair uses the same extreme wing 0.38 and fold 0.14 profile as all alternative gear examples.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_pair_alternative.png Temple Fay pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_temple_fay_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_temple_fay(pair=true);
