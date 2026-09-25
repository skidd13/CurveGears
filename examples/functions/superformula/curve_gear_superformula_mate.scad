/***
 * @function superformula_curve_gear_mate
 * @brief Render the conjugate Superformula mate generated from the driver pitch curve.
 * Source: [`functions/superformula/curve_gear_superformula_mate.scad`](functions/superformula/curve_gear_superformula_mate.scad)
 * @image ../images/functions/superformula/curve_gear_superformula_mate.png curve_gear_superformula_mate example preview
 */
include <../../../src/superformula/mate.scad>;
$fn=64;
curve_gear_superformula_mate(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
