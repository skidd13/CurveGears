/***
 * @function curve_gear_logistic_dwell_mate_example
 */
include <../../../src/logistic_dwell/mate.scad>
include <../../palette.scad>;
color(example_mate_color)
curve_gear_logistic_dwell_mate(.8,34,4,4.8,gain=8,depth=.2,samples=240);
