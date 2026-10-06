/***
 * @function curve_gear_ellipse_body_2d
 * @brief Render the ellipse body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/ellipse/curve_gear_ellipse_body_2d.scad`](functions/ellipse/curve_gear_ellipse_body_2d.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse_body_2d.png ellipse 2D body outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/ellipse/gear.scad>;
curve_gear_ellipse_body_2d(0.8, 34, 4.8, eccentricity=0.72, body_offset=-2);
