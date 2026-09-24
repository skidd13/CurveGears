/***
 * @function cassini_curve_gear_mate_rotation
 * @brief Show the Cassini mate-rotation calculation used for pair assembly.
 * Source: [`functions/cassini/curve_gear_cassini_mate_rotation.scad`](functions/cassini/curve_gear_cassini_mate_rotation.scad)
 */
include <../../../src/cassini/mate.scad>;
echo("curve_gear_cassini_mate_rotation", curve_gear_cassini_mate_rotation(.8,34,.78,360,37));
