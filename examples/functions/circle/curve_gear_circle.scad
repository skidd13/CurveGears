/***
 * @function circle_curve_gear
 * @brief Render a Circle gear from the documented pitch-curve family.
 * Source: [`functions/circle/curve_gear_circle.scad`](functions/circle/curve_gear_circle.scad)
 * @image ../images/functions/circle/curve_gear_circle.png curve gear circle preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/circle/gear.scad>;
include <../../palette.scad>;
module _main_example_circle() {
    curve_gear_circle(.8,34,4,4.8);
}
color(example_driver_color)
_main_example_circle();
