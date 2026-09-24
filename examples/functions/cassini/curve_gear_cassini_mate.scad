/***
 * @function cassini_curve_gear_mate
 * @brief Render the conjugate Cassini mate generated from the driver pitch curve.
 * Source: [`functions/cassini/curve_gear_cassini_mate.scad`](functions/cassini/curve_gear_cassini_mate.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_mate.png curve_gear_cassini_mate example preview
 */
include <../../../src/cassini/mate.scad>;
$fn=64;
curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.78,samples=360);
