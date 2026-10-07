/** @function curve_gear_tanh_triad_body_2d_example
 * @brief Tanh Triad body 2D example.
 */
include <../../../src/tanh_triad/gear.scad>
include <../../palette.scad>;
color(example_driver_color)
curve_gear_tanh_triad_body_2d(.8,34,4.8,samples=240,body_offset=-2);
