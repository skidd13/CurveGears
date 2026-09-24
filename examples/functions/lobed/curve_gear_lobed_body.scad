/***
 * @file curve_gear_lobed_body example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/lobed/mate.scad>;
$fn=64;
curve_gear_lobed_body(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
