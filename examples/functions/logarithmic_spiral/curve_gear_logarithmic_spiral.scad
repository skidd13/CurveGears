/***
 * @function logarithmic_spiral_curve_gear
 * @brief Render a Logarithmic spiral gear from the documented pitch-curve family.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png curve_gear_logarithmic_spiral example preview
 */
include <../../../src/logarithmic_spiral/mate.scad>;
$fn=64;
module _main_example_logarithmic_spiral() {
    curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
}
_main_example_logarithmic_spiral();
