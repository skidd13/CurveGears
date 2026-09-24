/***
 * @function superformula_curve_gear_centre_distance
 * @brief Show the Superformula centre-distance calculation used for pair placement.
 * Source: [`functions/superformula/curve_gear_superformula_centre_distance.scad`](functions/superformula/curve_gear_superformula_centre_distance.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/superformula/mate.scad>;
echo("curve_gear_superformula_centre_distance", curve_gear_superformula_centre_distance(.5,80,5,1,1,.9,3.4,3.4));
