/***
 * @function pascal_curve_gear_centre_distance
 * @brief Show the Pascal centre-distance calculation used for pair placement.
 * Source: [`functions/pascal/curve_gear_pascal_centre_distance.scad`](functions/pascal/curve_gear_pascal_centre_distance.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/pascal/mate.scad>;
echo("curve_gear_pascal_centre_distance", curve_gear_pascal_centre_distance(.8,34,.35,240));
