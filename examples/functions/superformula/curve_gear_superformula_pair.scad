/***
 * @file curve_gear_superformula_pair example
 * @brief One-to-one executable example for the documented public API.
 */
include <../../../src/superformula/pair.scad>;
$fn=64;
curve_gear_superformula_pair(.8,34,4,4.8,symmetry=5,n1=1.8,n2=3.4,n3=3.4,samples=360,phase=37);
