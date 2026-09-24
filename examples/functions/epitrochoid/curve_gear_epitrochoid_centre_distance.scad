/***
 * @function epitrochoid_curve_gear_centre_distance
 * @brief Show the Epitrochoid centre-distance calculation used for pair placement.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad`](functions/epitrochoid/curve_gear_epitrochoid_centre_distance.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/epitrochoid/mate.scad>;
echo("curve_gear_epitrochoid_centre_distance", curve_gear_epitrochoid_centre_distance(.8,34,3,1,.35,240));
