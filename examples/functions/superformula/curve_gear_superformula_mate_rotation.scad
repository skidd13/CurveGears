/***
 * @function superformula_curve_gear_mate_rotation
 * @brief Show the Superformula mate-rotation calculation used for pair assembly.
 * Source: [`functions/superformula/curve_gear_superformula_mate_rotation.scad`](functions/superformula/curve_gear_superformula_mate_rotation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/superformula/mate.scad>;
echo("curve_gear_superformula_mate_rotation", curve_gear_superformula_mate_rotation(.5,80,5,1,1,.9,3.4,3.4,240,37));
