/***
 * @file curve_gear_cassini_mate example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/cassini/mate.scad>;
$fn=64;
curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.78,samples=360);
