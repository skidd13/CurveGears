/***
 * @function curve_gear_fourier_body_2d
 * @brief Render the fourier body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/fourier/curve_gear_fourier_body_2d.scad`](functions/fourier/curve_gear_fourier_body_2d.scad)
 * @image ../images/functions/fourier/curve_gear_fourier_body_2d.png fourier 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/fourier/gear.scad>;
include <../../palette.scad>;
color(example_driver_color)
curve_gear_fourier_body_2d(0.8, 34, 4.8, coefficients=[[2,0.22,0],[3,0.08,30]], samples=240);
