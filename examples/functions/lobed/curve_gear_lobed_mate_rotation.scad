/***
 * @function lobed_curve_gear_mate_rotation
 * @brief Show the Lobed mate-rotation calculation used for pair assembly.
 * Source: [`functions/lobed/curve_gear_lobed_mate_rotation.scad`](functions/lobed/curve_gear_lobed_mate_rotation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/lobed/mate.scad>;
echo("curve_gear_lobed_mate_rotation", curve_gear_lobed_mate_rotation(.8,34,4,.13,240,37));
