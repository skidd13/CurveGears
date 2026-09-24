/***
 * @function fourier_curve_gear
 * @brief Render a Fourier gear from the documented pitch-curve family.
 * Source: [`functions/fourier/curve_gear_fourier.scad`](functions/fourier/curve_gear_fourier.scad)
 * @image ../images/functions/fourier/curve_gear_fourier.png curve_gear_fourier example preview
 */
include <../../../src/fourier/mate.scad>;
$fn=64;
curve_gear_fourier(.8,34,4,4.8,coefficients=[[2,.10,0],[3,.04,30]],samples=240);
