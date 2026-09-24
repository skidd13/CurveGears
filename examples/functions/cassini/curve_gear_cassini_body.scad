/***
 * @function cassini_curve_gear_body
 * @brief Render the Cassini body before tooth placement.
 * Source: [`functions/cassini/curve_gear_cassini_body.scad`](functions/cassini/curve_gear_cassini_body.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_body.png curve_gear_cassini_body example preview
 */
include <../../../src/cassini/gear.scad>;
$fn=64;
curve_gear_cassini_body(.8,34,4,4.8,focus_ratio=.78,samples=360);
