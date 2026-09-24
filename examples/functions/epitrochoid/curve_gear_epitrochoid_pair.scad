/***
 * @file curve_gear_epitrochoid_pair example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/epitrochoid/pair.scad>;
$fn=64;
curve_gear_epitrochoid_pair(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=240,phase=37);
