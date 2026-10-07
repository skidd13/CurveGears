/***
 * @function cassini_curve_gear_pair
 * @brief Render a complete Cassini gear pair with derived conjugate motion.
 * Source: [`functions/cassini/curve_gear_cassini_pair.scad`](functions/cassini/curve_gear_cassini_pair.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_pair.png curve_gear_cassini_pair example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cassini/pair.scad>;
include <../../palette.scad>;
$fn=64;
curve_gear_cassini_pair(.8,34,4,4.8,focus_ratio=.92,samples=360,phase=37,driver_color=example_driver_color,mate_color=example_mate_color);
