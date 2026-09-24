/***
 * @function superformula_curve_gear_body
 * @brief Render the Superformula body before tooth placement.
 * Source: [`functions/superformula/curve_gear_superformula_body.scad`](functions/superformula/curve_gear_superformula_body.scad)
 * @image ../images/functions/superformula/curve_gear_superformula_body.png curve_gear_superformula_body example preview
 */
include <../../../src/superformula/mate.scad>;
$fn=64;
curve_gear_superformula_body(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
