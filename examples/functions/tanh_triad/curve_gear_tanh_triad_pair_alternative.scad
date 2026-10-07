/***
 * @function tanh_triad_curve_gear_pair_alternative
 * @brief Tanh Triad alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/tanh_triad/curve_gear_tanh_triad_pair_alternative.scad`](functions/tanh_triad/curve_gear_tanh_triad_pair_alternative.scad)
 * A broad smooth triad with transition 0.8 and crest 0.32 replaces the canonical sharper, corrected triad. Removing the sixth-harmonic correction isolates the three-lobed tanh law; coarse teeth expose its boundary.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_pair_alternative.png Tanh Triad pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_tanh_triad_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_tanh_triad(pair=true);
