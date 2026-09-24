/***
 * @file curve_gear_pascal_mate_rotation example
 * @brief One-to-one executable example for the documented scalar API.
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/pascal/mate.scad>;
echo("curve_gear_pascal_mate_rotation", curve_gear_pascal_mate_rotation(.8,34,.35,240,37));
