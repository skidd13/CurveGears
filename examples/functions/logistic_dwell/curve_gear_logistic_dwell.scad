/** @function curve_gear_logistic_dwell_example
 * @brief Logistic Dwell gear example.
 */
include <../../../src/logistic_dwell/gear.scad>
include <../../palette.scad>;
$fn=64;
module _main_example_logistic_dwell() { curve_gear_logistic_dwell(.8,34,4,4.8,samples=240); }
color(example_driver_color)
_main_example_logistic_dwell();
