/***
 * @file curve_gear_ellipse_pair example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/ellipse/pair.scad>;
$fn=64;
curve_gear_ellipse_pair(.8,34,4,4.8,eccentricity=.72,samples=240,phase=37);
