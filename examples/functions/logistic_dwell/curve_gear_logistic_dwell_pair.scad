/***
 * @function curve_gear_logistic_dwell_pair_example
 */
include <../../../src/logistic_dwell/pair.scad>
include <../../palette.scad>;
curve_gear_logistic_dwell_pair(.8,34,4,4.8,gain=8,depth=.2,samples=240,together_built=true,backlash=.3,driver_color=example_driver_color,mate_color=example_mate_color);
