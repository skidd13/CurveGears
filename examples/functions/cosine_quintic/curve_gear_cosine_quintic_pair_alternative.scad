/***
 * @function cosine_quintic_curve_gear_pair_alternative
 * @brief Cosine Quintic alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.scad`](functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.scad)
 * Three pronounced signed-cosine plateaux replace the canonical two-harmonic form. Harmonic 3 and depth 0.16 expose how the fifth power concentrates the radial excursions.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.png Cosine Quintic pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cosine_quintic_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_cosine_quintic(pair=true);
