/***
 * @function cassini_curve_gear_pair
 * @brief Render a complete Cassini gear pair with derived conjugate motion.
 * Source: [`functions/cassini/curve_gear_cassini_pair.scad`](functions/cassini/curve_gear_cassini_pair.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_pair.png curve_gear_cassini_pair example preview
 */
include <../../../src/cassini/pair.scad>;
$fn=64;
curve_gear_cassini_pair(.8,34,4,4.8,focus_ratio=.78,samples=360,phase=37);
