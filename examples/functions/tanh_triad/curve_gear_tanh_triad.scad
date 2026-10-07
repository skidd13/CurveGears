/** @function curve_gear_tanh_triad_example
 * @brief Tanh Triad gear example.
 */
include <../../../src/tanh_triad/gear.scad>
include <../../palette.scad>;
$fn=64;
module _main_example_tanh_triad() { curve_gear_tanh_triad(.8,34,4,4.8,samples=240); }
color(example_driver_color)
_main_example_tanh_triad();
