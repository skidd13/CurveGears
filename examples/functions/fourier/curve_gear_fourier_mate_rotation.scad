/***
 * @function fourier_curve_gear_mate_rotation
 * @brief Show the Fourier mate-rotation calculation used for pair assembly.
 * Source: [`functions/fourier/curve_gear_fourier_mate_rotation.scad`](functions/fourier/curve_gear_fourier_mate_rotation.scad)
 *
 * The result is deliberately emitted as an OpenSCAD console value because
 * this callable returns a number rather than geometry.
 */
include <../../../src/fourier/mate.scad>;
echo("curve_gear_fourier_mate_rotation", curve_gear_fourier_mate_rotation(.8,34,[[2,.10,0],[3,.04,30]],240,37));
