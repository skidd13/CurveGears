/** @function curve_gear_tanh_triad_mate_example
 * @brief Tanh Triad mate example.
 */
include <../../../src/tanh_triad/mate.scad>
include <../../palette.scad>;
color(example_mate_color)
curve_gear_tanh_triad_mate(.8,34,4,4.8,samples=240);
