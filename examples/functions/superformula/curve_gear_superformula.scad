/***
 * @function superformula_curve_gear
 * @brief Render a Superformula gear from the documented pitch-curve family.
 * Source: [`functions/superformula/curve_gear_superformula.scad`](functions/superformula/curve_gear_superformula.scad)
 * @image ../images/functions/superformula/curve_gear_superformula.png curve_gear_superformula example preview
 */
include <../../../src/superformula/mate.scad>;
$fn=64;
curve_gear_superformula(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
