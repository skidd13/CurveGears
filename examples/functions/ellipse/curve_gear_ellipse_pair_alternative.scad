/***
 * @function ellipse_curve_gear_pair_alternative
 * @brief Ellipse alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/ellipse/curve_gear_ellipse_pair_alternative.scad`](functions/ellipse/curve_gear_ellipse_pair_alternative.scad)
 * Eccentricity 0.94 produces a long narrow ellipse rather than the canonical 0.72 oval. The sharper ends and narrow transverse span reveal where tooth placement becomes demanding.
 * @image ../images/functions/ellipse/curve_gear_ellipse_pair_alternative.png Ellipse pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_ellipse_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_ellipse(pair=true);
