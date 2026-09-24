/***
 * @file curve_gear_fourier example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/fourier/mate.scad>;
$fn=64;
curve_gear_fourier(.8,34,4,4.8,coefficients=[[2,.10,0],[3,.04,30]],samples=240);
