/***
 * @function tanh_triad_invalid_pair_parameters
 * @brief Reject invalid curve controls consistently at the pair entry point.
 * Source: [`tanh_triad/invalid_pair_parameters.scad`](tanh_triad/invalid_pair_parameters.scad)
 */
include <../../src/tanh_triad/pair.scad>
curve_gear_tanh_triad_pair(.8,34,3,4.8,transition=-1,samples=120);
