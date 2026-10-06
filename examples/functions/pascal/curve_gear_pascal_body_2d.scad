/***
 * @function curve_gear_pascal_body_2d
 * @brief Render the pascal body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/pascal/curve_gear_pascal_body_2d.scad`](functions/pascal/curve_gear_pascal_body_2d.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_body_2d.png pascal 2D body outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/pascal/gear.scad>;
curve_gear_pascal_body_2d(0.8, 34, 4.8, eccentricity=0.25, body_offset=-2);
