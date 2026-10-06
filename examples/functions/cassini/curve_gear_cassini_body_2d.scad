/***
 * @function curve_gear_cassini_body_2d
 * @brief Render the cassini body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/cassini/curve_gear_cassini_body_2d.scad`](functions/cassini/curve_gear_cassini_body_2d.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_body_2d.png cassini 2D body outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/cassini/gear.scad>;
curve_gear_cassini_body_2d(0.8, 34, 4.8, focus_ratio=0.78, body_offset=-2);
