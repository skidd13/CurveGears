/***
 * @function cosine_quintic_invalid_pair_parameters
 * @brief Reject invalid curve controls consistently at the pair entry point.
 * Source: [`cosine_quintic/invalid_pair_parameters.scad`](cosine_quintic/invalid_pair_parameters.scad)
 */
include <../../src/cosine_quintic/pair.scad>
curve_gear_cosine_quintic_pair(.8,34,3,4.8,depth=0,harmonic=0,samples=120);
