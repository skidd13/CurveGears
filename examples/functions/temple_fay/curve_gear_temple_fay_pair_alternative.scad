/***
 * @function temple_fay_curve_gear_pair_alternative
 * @brief Temple Fay alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_pair_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_pair_alternative.scad)
 * The meshed alternative uses wing 0.05 and fold 0.01, the validated collision-free pair fixture. Its standalone comparison shows the stronger wing 0.32 and fold 0.12 profile.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_pair_alternative.png Temple Fay pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_temple_fay_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_temple_fay(pair=true);
