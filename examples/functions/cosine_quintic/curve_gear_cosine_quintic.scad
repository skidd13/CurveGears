/***
 * @function curve_gear_cosine_quintic_example
 * @brief Cosine Quintic gear example.
 */
include <../../../src/cosine_quintic/gear.scad>
include <../../palette.scad>;
module _main_example_cosine_quintic() { curve_gear_cosine_quintic(.8,34,4,4.8,samples=240); }
color(example_driver_color)
_main_example_cosine_quintic();
