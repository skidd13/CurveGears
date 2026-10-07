/***
 * @function logarithmic_spiral_curve_gear_pair_alternative
 * @brief Logarithmic spiral alternative pair: The alternative curve and its mate displayed separately for inspection.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair_alternative.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair_alternative.scad)
 * Three spiral sectors replace the canonical single return. Growth 1.22 increases the radial sweep. Returns are broad transitions without ordinary teeth, and the pair is a static reference rather than a validated conjugate transmission.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair_alternative.png Logarithmic spiral pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_logarithmic_spiral_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_logarithmic_spiral(pair=true);
