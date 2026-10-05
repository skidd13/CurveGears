/***
 * @function curve_gear_superformula_body_2d
 * @brief Render the superformula body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/superformula/curve_gear_superformula_body_2d.scad`](functions/superformula/curve_gear_superformula_body_2d.scad)
 * @image ../images/functions/superformula/curve_gear_superformula_body_2d.png superformula 2D body profile
 */
include <../../../src/superformula/gear.scad>;
curve_gear_superformula_body_2d(0.5, 80, 4.8, symmetry=5, n1=0.9, n2=3.4, n3=3.4, samples=240, body_offset=-2);
