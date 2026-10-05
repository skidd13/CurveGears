/***
 * @function curve_gear_bezier_body_2d
 * @brief Render the bezier body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/bezier/curve_gear_bezier_body_2d.scad`](functions/bezier/curve_gear_bezier_body_2d.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_body_2d.png bezier 2D body profile
 */
include <../../../src/bezier/gear.scad>;
curve_gear_bezier_body_2d(0.8, 34, 4.8, body_offset=-2);
