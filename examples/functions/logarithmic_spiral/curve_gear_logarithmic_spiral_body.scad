/***
 * @function logarithmic_spiral_curve_gear_body
 * @brief Render the Logarithmic spiral body before tooth placement.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png curve_gear_logarithmic_spiral_body example preview
 */
include <../../../src/logarithmic_spiral/mate.scad>;
$fn=64;
curve_gear_logarithmic_spiral_body(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
