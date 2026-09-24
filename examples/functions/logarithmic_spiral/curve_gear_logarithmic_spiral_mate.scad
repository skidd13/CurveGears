/***
 * @function logarithmic_spiral_curve_gear_mate
 * @brief Render the conjugate Logarithmic spiral mate generated from the driver pitch curve.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.png curve_gear_logarithmic_spiral_mate example preview
 */
include <../../../src/logarithmic_spiral/mate.scad>;
$fn=64;
curve_gear_logarithmic_spiral_mate(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
