/***
 * @function logarithmic_spiral_curve_gear_reference_separation
 * @brief Show the Logarithmic spiral reference-separation calculation.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_reference_separation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/logarithmic_spiral/mate.scad>;
echo("curve_gear_logarithmic_spiral_reference_separation", curve_gear_logarithmic_spiral_reference_separation(.8,34,1,1.17,0));
