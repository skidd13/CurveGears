/***
 * @function logarithmic_spiral_curve_gear
 * @brief Render a Logarithmic spiral gear from the documented pitch-curve family.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png curve_gear_logarithmic_spiral example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/logarithmic_spiral/mate.scad>;
include <../../palette.scad>;
$fn=64;
module _main_example_logarithmic_spiral() {
    curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
}
color(example_driver_color)
_main_example_logarithmic_spiral();
