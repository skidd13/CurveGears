/***
 * @file curve_gear_superformula example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/superformula/mate.scad>;
$fn=64;
curve_gear_superformula(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
