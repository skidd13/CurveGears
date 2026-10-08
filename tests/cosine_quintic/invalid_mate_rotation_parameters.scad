/***
 * @function cosine_quintic_invalid_mate_rotation_parameters
 * @brief Reject invalid curve controls consistently at the mate_rotation entry point.
 * Source: [`cosine_quintic/invalid_mate_rotation_parameters.scad`](cosine_quintic/invalid_mate_rotation_parameters.scad)
 */
include <../../src/cosine_quintic/pair.scad>
echo(curve_gear_cosine_quintic_mate_rotation(.8,34,depth=0,harmonic=0,samples=120));
cube(.01);
