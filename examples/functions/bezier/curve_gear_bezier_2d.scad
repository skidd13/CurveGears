/***
 * @function curve_gear_bezier_2d
 * @brief Render the complete bezier gear profile as flat 2D geometry.
 * Source: [`functions/bezier/curve_gear_bezier_2d.scad`](functions/bezier/curve_gear_bezier_2d.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_2d.png bezier 2D gear outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/bezier/gear.scad>;
curve_gear_bezier_2d(0.8, 34, 4.8);
