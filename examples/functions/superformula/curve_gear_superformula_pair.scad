/***
 * @function superformula_curve_gear_pair
 * @brief Render a complete Superformula gear pair with derived conjugate motion.
 * Source: [`functions/superformula/curve_gear_superformula_pair.scad`](functions/superformula/curve_gear_superformula_pair.scad)
 * @image ../images/functions/superformula/curve_gear_superformula_pair.png curve_gear_superformula_pair example preview
 */
include <../../../src/superformula/pair.scad>;
$fn=64;
curve_gear_superformula_pair(.8,34,4,4.8,symmetry=5,n1=1.8,n2=3.4,n3=3.4,samples=360,phase=37);
