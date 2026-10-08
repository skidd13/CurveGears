/***
 * @function cosine_quintic_invalid_centre_distance_parameters
 * @brief Reject invalid curve controls consistently at the centre_distance entry point.
 * Source: [`cosine_quintic/invalid_centre_distance_parameters.scad`](cosine_quintic/invalid_centre_distance_parameters.scad)
 */
include <../../src/cosine_quintic/pair.scad>
echo(curve_gear_cosine_quintic_centre_distance(.8,34,depth=0,harmonic=0,samples=120));
cube(.01);
