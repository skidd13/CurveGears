/***
 * @function curve_gear_temple_fay_example
 * @brief Temple Fay gear example.
 */
include <../../../src/temple_fay/gear.scad>
include <../../palette.scad>;
module _main_example_temple_fay() { curve_gear_temple_fay(.8,34,4,4.8,samples=240); }
color(example_driver_color)
_main_example_temple_fay();
