/***
 * @function ellipse_curve_gear_centre_distance
 * @brief Show the Ellipse centre-distance calculation used for pair placement.
 * Source: [`functions/ellipse/curve_gear_ellipse_centre_distance.scad`](functions/ellipse/curve_gear_ellipse_centre_distance.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/ellipse/mate.scad>;
echo("curve_gear_ellipse_centre_distance", curve_gear_ellipse_centre_distance(.8,34,.72));
