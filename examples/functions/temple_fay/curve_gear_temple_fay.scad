/***
 * @function curve_gear_temple_fay_example
 * @brief Temple Fay gear example.
 */
include <../../../src/temple_fay/gear.scad>
module _main_example_temple_fay() { curve_gear_temple_fay(.8,34,4,4.8,samples=240); }
_main_example_temple_fay();
