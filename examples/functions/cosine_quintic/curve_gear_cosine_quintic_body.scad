/***
 * @function curve_gear_cosine_quintic_body_example
 */
include <../../../src/cosine_quintic/gear.scad>
include <../../palette.scad>;
color(example_driver_color)
curve_gear_cosine_quintic_body(.8,34,4,4.8,samples=240);
