/***
 * @function circle_curve_gear_pair
 * @brief Render a complete Circle gear pair with derived conjugate motion.
 * Source: [`functions/circle/curve_gear_circle_pair.scad`](functions/circle/curve_gear_circle_pair.scad)
 * @image ../images/functions/circle/curve_gear_circle_pair.png curve gear circle pair preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/circle/pair.scad>
include <../../palette.scad>;
curve_gear_circle_pair(.8,34,4,4.8,driver_color=example_driver_color,mate_color=example_mate_color);
