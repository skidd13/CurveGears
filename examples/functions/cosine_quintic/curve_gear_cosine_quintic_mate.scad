/***
 * @function curve_gear_cosine_quintic_mate_example
 */
include <../../../src/cosine_quintic/mate.scad>
include <../../palette.scad>;
color(example_mate_color)
curve_gear_cosine_quintic_mate(.8,34,4,4.8,samples=240);
