/***
 * @function cassini_curve_gear_mate
 * @brief Render the conjugate Cassini mate generated from the driver pitch curve.
 * Source: [`functions/cassini/curve_gear_cassini_mate.scad`](functions/cassini/curve_gear_cassini_mate.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_mate.png curve_gear_cassini_mate example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cassini/mate.scad>;
include <../../palette.scad>;
$fn=64;
color(example_mate_color)
curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.92,samples=360);
