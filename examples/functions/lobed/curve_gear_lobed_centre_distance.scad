/***
 * @function lobed_curve_gear_centre_distance
 * @brief Show the Lobed centre-distance calculation used for pair placement.
 * Source: [`functions/lobed/curve_gear_lobed_centre_distance.scad`](functions/lobed/curve_gear_lobed_centre_distance.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/lobed/mate.scad>;
echo("curve_gear_lobed_centre_distance", curve_gear_lobed_centre_distance(.8,34,4,.13));
