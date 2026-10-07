/***
 * @function fourier_curve_gear_body
 * @brief Render the Fourier body before tooth placement.
 * Source: [`functions/fourier/curve_gear_fourier_body.scad`](functions/fourier/curve_gear_fourier_body.scad)
 * @image ../images/functions/fourier/curve_gear_fourier_body.png curve_gear_fourier_body example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/fourier/mate.scad>;
include <../../palette.scad>;
$fn=64;
color(example_driver_color)
curve_gear_fourier_body(.8,34,4,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
