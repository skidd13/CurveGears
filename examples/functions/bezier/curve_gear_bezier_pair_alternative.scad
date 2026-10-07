/***
 * @function bezier_curve_gear_pair_alternative
 * @brief Bézier alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/bezier/curve_gear_bezier_pair_alternative.scad`](functions/bezier/curve_gear_bezier_pair_alternative.scad)
 * An elongated asymmetric oval replaces the compact canonical outline. Unequal left/right handles and a narrow vertical span expose the effect of control-point geometry.
 * @image ../images/functions/bezier/curve_gear_bezier_pair_alternative.png Bézier pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_bezier_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_bezier(pair=true);
