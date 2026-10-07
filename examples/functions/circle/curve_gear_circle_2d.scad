/***
 * @function curve_gear_circle_2d
 * @brief Render the complete circle gear profile as flat 2D geometry.
 * Source: [`functions/circle/curve_gear_circle_2d.scad`](functions/circle/curve_gear_circle_2d.scad)
 * @image ../images/functions/circle/curve_gear_circle_2d.png circle 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/circle/gear.scad>;
include <../../palette.scad>;
color(example_driver_color)
curve_gear_circle_2d(0.8, 34, 4.8);
