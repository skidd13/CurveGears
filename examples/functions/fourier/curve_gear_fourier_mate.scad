/***
 * @function fourier_curve_gear_mate
 * @brief Render the conjugate Fourier mate generated from the driver pitch curve.
 * Source: [`functions/fourier/curve_gear_fourier_mate.scad`](functions/fourier/curve_gear_fourier_mate.scad)
 * @image ../images/functions/fourier/curve_gear_fourier_mate.png curve_gear_fourier_mate example preview
 */
include <../../../src/fourier/mate.scad>;
$fn=64;
curve_gear_fourier_mate(.8,34,4,4.8,coefficients=[[2,.10,0],[3,.04,30]],samples=240);
