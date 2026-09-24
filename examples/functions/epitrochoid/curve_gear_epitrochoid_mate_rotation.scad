/***
 * @function epitrochoid_curve_gear_mate_rotation
 * @brief Show the Epitrochoid mate-rotation calculation used for pair assembly.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate_rotation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/epitrochoid/mate.scad>;
echo("curve_gear_epitrochoid_mate_rotation", curve_gear_epitrochoid_mate_rotation(.8,34,3,1,.35,240,37));
