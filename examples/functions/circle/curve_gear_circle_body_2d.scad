/***
 * @function curve_gear_circle_body_2d
 * @brief Render the circle body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/circle/curve_gear_circle_body_2d.scad`](functions/circle/curve_gear_circle_body_2d.scad)
 * @image ../images/functions/circle/curve_gear_circle_body_2d.png circle 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/circle/gear.scad>;
include <../../palette.scad>;
color(example_driver_color)
curve_gear_circle_body_2d(0.8, 34, 4.8);
