/***
 * @function cusp_curve_gear_pair_alternative
 * @brief Cusp alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/cusp/curve_gear_cusp_pair_alternative.scad`](functions/cusp/curve_gear_cusp_pair_alternative.scad)
 * A thin plate contrasts with the thick canonical gear; the bore remains 4.8 mm. The deltoid pitch law is fixed; the validated 36-tooth count is retained while thickness reveals the body structure.
 * @image ../images/functions/cusp/curve_gear_cusp_pair_alternative.png Cusp pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cusp_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_cusp(pair=true);
