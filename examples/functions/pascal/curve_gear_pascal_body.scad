/***
 * @file curve_gear_pascal_body example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/pascal/mate.scad>;
$fn=64;
curve_gear_pascal_body(.8,34,4,4.8,eccentricity=.35,samples=240);
