/***
 * @function fourier_curve_gear_pair_alternative
 * @brief Fourier alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/fourier/curve_gear_fourier_pair_alternative.scad`](functions/fourier/curve_gear_fourier_pair_alternative.scad)
 * A single strong third harmonic produces three clear lobes instead of the canonical mixed second/third-harmonic oval. This isolates harmonic count from mixed-phase asymmetry.
 * @image ../images/functions/fourier/curve_gear_fourier_pair_alternative.png Fourier pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_fourier_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_fourier(pair=true);
