/***
 * @file curve_gear_logarithmic_spiral_reference_separation example
 * @brief One-to-one executable example for the documented scalar API.
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/logarithmic_spiral/mate.scad>;
echo("curve_gear_logarithmic_spiral_reference_separation", curve_gear_logarithmic_spiral_reference_separation(.8,34,1,1.17,0));
