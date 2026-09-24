/***
 * @file curve_gear_logarithmic_spiral_pair example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/logarithmic_spiral/pair.scad>;
$fn=64;
curve_gear_logarithmic_spiral_pair(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
