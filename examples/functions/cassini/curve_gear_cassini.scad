/***
 * @file curve_gear_cassini example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/cassini/gear.scad>;
$fn=64;
curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=360);
