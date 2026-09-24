/***
 * @file curve_gear_pascal_pair example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/pascal/pair.scad>;
$fn=64;
curve_gear_pascal_pair(.8,34,4,4.8,eccentricity=.35,samples=240,phase=37);
