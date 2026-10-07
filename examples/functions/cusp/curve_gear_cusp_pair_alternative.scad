/***
 * @function cusp_curve_gear_pair_alternative
 * @brief Cusp alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/cusp/curve_gear_cusp_pair_alternative.scad`](functions/cusp/curve_gear_cusp_pair_alternative.scad)
 * Five cusps replace the canonical three-cusp deltoid. With 60 tooth positions, each cusp sector retains twelve tooth positions; the bore remains 4.8 mm. Set `cusps=5` and keep tooth count and samples divisible by five.
 * @image ../images/functions/cusp/curve_gear_cusp_pair_alternative.png Cusp pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cusp_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_cusp(pair=true);
