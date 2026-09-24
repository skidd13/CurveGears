/***
 * @function fourier_curve_gear_pair
 * @brief Render a complete Fourier gear pair with derived conjugate motion.
 * Source: [`functions/fourier/curve_gear_fourier_pair.scad`](functions/fourier/curve_gear_fourier_pair.scad)
 * @image ../images/functions/fourier/curve_gear_fourier_pair.png curve_gear_fourier_pair example preview
 */
include <../../../src/fourier/pair.scad>;
$fn=64;
curve_gear_fourier_pair(.8,34,4,4.8,coefficients=[[2,.10,0],[3,.04,30]],samples=240,phase=37);
