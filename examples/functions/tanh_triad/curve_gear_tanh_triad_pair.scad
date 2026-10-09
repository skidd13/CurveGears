/** @function curve_gear_tanh_triad_pair_example
 * @brief Tanh Triad pair example.
 */
include <../../../src/tanh_triad/pair.scad>
include <../../palette.scad>;
curve_gear_tanh_triad_pair(.8,34,4,4.8,samples=240,together_built=true,backlash=.8,driver_color=example_driver_color,mate_color=example_mate_color);
