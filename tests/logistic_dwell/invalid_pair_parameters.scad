/***
 * @function logistic_dwell_invalid_pair_parameters
 * @brief Reject invalid curve controls consistently at the pair entry point.
 * Source: [`logistic_dwell/invalid_pair_parameters.scad`](logistic_dwell/invalid_pair_parameters.scad)
 */
include <../../src/logistic_dwell/pair.scad>
curve_gear_logistic_dwell_pair(.8,34,3,4.8,gain=-1,samples=120);
