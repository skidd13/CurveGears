/***
 * @file curve_gear_bezier_mate example
 * @brief One-to-one executable example for the admissible Bézier mate API.
 */
include <../../../src/bezier/mate.scad>;
$fn=64;
curve_gear_bezier_mate(.8,34,4,4.8,samples=240);
