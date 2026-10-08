/***
 * @function tanh_triad_invalid_mate_rotation_parameters
 * @brief Reject invalid curve controls consistently at the mate_rotation entry point.
 * Source: [`tanh_triad/invalid_mate_rotation_parameters.scad`](tanh_triad/invalid_mate_rotation_parameters.scad)
 */
include <../../src/tanh_triad/pair.scad>
echo(curve_gear_tanh_triad_mate_rotation(.8,34,transition=-1,samples=120));
cube(.01);
