/***
 * @function fourier_curve_gear_body
 * @brief Render the Fourier body before tooth placement.
 * Source: [`functions/fourier/curve_gear_fourier_body.scad`](functions/fourier/curve_gear_fourier_body.scad)
 * @image ../images/functions/fourier/curve_gear_fourier_body.png curve_gear_fourier_body example preview
 */
include <../../../src/fourier/mate.scad>;
$fn=64;
curve_gear_fourier_body(.8,34,4,4.8,coefficients=[[2,.10,0],[3,.04,30]],samples=240);
