/***
 * @function curve_gear_logistic_dwell_body_2d_example
 */
include <../../../src/logistic_dwell/gear.scad>
include <../../palette.scad>;
color(example_driver_color)
curve_gear_logistic_dwell_body_2d(.8,34,4.8,gain=8,depth=.2,samples=240);
