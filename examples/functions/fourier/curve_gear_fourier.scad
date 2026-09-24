/***
 * @function fourier_curve_gear
 * @brief Render a two-harmonic Fourier gear with visibly modulated lobes.
 * Source: [`functions/fourier/curve_gear_fourier.scad`](functions/fourier/curve_gear_fourier.scad)
 * @image ../images/functions/fourier/curve_gear_fourier.png curve_gear_fourier example preview
 */
include <../../../src/fourier/mate.scad>;
$fn=64;
module _main_example_fourier() {
    curve_gear_fourier(.8,34,4,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
}
_main_example_fourier();
