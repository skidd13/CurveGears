/***
 * @function ellipse_curve_gear_mate_rotation
 * @brief Show the Ellipse mate-rotation calculation used for pair assembly.
 * Source: [`functions/ellipse/curve_gear_ellipse_mate_rotation.scad`](functions/ellipse/curve_gear_ellipse_mate_rotation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/ellipse/mate.scad>;
echo("curve_gear_ellipse_mate_rotation", curve_gear_ellipse_mate_rotation(.8,34,.72,240,37));
