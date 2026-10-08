/***
 * @function tanh_triad_invalid_mate_parameters
 * @brief Reject invalid curve controls consistently at the mate entry point.
 * Source: [`tanh_triad/invalid_mate_parameters.scad`](tanh_triad/invalid_mate_parameters.scad)
 */
include <../../src/tanh_triad/pair.scad>
curve_gear_tanh_triad_mate(.8,34,3,4.8,transition=-1,samples=120);
