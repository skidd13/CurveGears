/** @function curve_gear_tanh_triad_body_example
 * @brief Tanh Triad body example.
 */
include <../../../src/tanh_triad/gear.scad>
include <../../palette.scad>;
color(example_driver_color)
curve_gear_tanh_triad_body(.8,34,4,4.8,samples=240);
