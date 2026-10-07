/***
 * @function lobed_curve_gear_pair_alternative
 * @brief Lobed alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/lobed/curve_gear_lobed_pair_alternative.scad`](functions/lobed/curve_gear_lobed_pair_alternative.scad)
 * Two deep lobes replace the canonical shallow four-lobed square form. Lobe count 2 and depth 0.28 show the transition to an elongated, waisted pitch curve.
 * @image ../images/functions/lobed/curve_gear_lobed_pair_alternative.png Lobed pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_lobed_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_lobed(pair=true);
