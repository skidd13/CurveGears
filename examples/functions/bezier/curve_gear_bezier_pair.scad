/***
 * @file curve_gear_bezier_pair example
 * @brief One-to-one executable example for the Bézier pair API.
 */
include <../../../src/bezier/pair.scad>;
$fn=64;
curve_gear_bezier_pair(.8,34,4,4.8,samples=240,together_built=false);
