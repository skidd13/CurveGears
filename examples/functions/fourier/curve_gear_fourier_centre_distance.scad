/***
 * @function fourier_curve_gear_centre_distance
 * @brief Show the Fourier centre-distance calculation used for pair placement.
 * Source: [`functions/fourier/curve_gear_fourier_centre_distance.scad`](functions/fourier/curve_gear_fourier_centre_distance.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/fourier/mate.scad>;
echo("curve_gear_fourier_centre_distance", curve_gear_fourier_centre_distance(.8,34,[[2,.10,0],[3,.04,30]]));
