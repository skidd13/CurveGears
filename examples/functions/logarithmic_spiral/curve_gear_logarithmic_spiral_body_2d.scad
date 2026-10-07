/***
 * @function curve_gear_logarithmic_spiral_body_2d
 * @brief Render the logarithmic_spiral body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.png logarithmic_spiral 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/logarithmic_spiral/gear.scad>;
include <../../palette.scad>;
color(example_driver_color)
curve_gear_logarithmic_spiral_body_2d(0.8, 34, 4.8, sectors=1, growth_rate=1.17, samples=240);
