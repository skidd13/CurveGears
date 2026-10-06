/***
 * @function curve_gear_superformula_2d
 * @brief Render the complete superformula gear profile as flat 2D geometry.
 * Source: [`functions/superformula/curve_gear_superformula_2d.scad`](functions/superformula/curve_gear_superformula_2d.scad)
 * @image ../images/functions/superformula/curve_gear_superformula_2d.png superformula 2D gear outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/superformula/gear.scad>;
curve_gear_superformula_2d(0.5, 80, 4.8, symmetry=5, n1=0.9, n2=3.4, n3=3.4, samples=240);
