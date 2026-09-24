/***
 * @function logarithmic_spiral_curve_gear_pair
 * @brief Render a complete Logarithmic spiral gear pair with derived conjugate motion.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.png curve_gear_logarithmic_spiral_pair example preview
 */
include <../../../src/logarithmic_spiral/pair.scad>;
$fn=64;
curve_gear_logarithmic_spiral_pair(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
