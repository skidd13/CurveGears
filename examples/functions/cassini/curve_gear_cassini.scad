/***
 * @function cassini_curve_gear
 * @brief Render a Cassini gear from the documented pitch-curve family.
 * Source: [`functions/cassini/curve_gear_cassini.scad`](functions/cassini/curve_gear_cassini.scad)
 * @image ../images/functions/cassini/curve_gear_cassini.png curve_gear_cassini example preview
 */
include <../../../src/cassini/gear.scad>;
$fn=64;
curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=360);
