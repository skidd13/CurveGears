/***
 * @function curve_gear_logarithmic_spiral_2d
 * @brief Render the complete logarithmic_spiral gear profile as flat 2D geometry.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.png logarithmic_spiral 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/logarithmic_spiral/gear.scad>;
curve_gear_logarithmic_spiral_2d(0.8, 34, 4.8, sectors=1, growth_rate=1.17, samples=240);
