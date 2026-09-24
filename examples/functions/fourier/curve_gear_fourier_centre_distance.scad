/***
 * @file curve_gear_fourier_centre_distance example
 * @brief One-to-one executable example for the documented scalar API.
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/fourier/mate.scad>;
echo("curve_gear_fourier_centre_distance", curve_gear_fourier_centre_distance(.8,34,[[2,.10,0],[3,.04,30]]));
