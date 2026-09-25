/***
 * @function pascal_curve_gear_mate_rotation
 * @brief Show the Pascal mate-rotation calculation used for pair assembly.
 * Source: [`functions/pascal/curve_gear_pascal_mate_rotation.scad`](functions/pascal/curve_gear_pascal_mate_rotation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/pascal/mate.scad>;
echo("curve_gear_pascal_mate_rotation", curve_gear_pascal_mate_rotation(.8,34,.60,240,37));
