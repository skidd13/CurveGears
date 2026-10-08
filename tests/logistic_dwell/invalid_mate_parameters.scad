/***
 * @function logistic_dwell_invalid_mate_parameters
 * @brief Reject invalid curve controls consistently at the mate entry point.
 * Source: [`logistic_dwell/invalid_mate_parameters.scad`](logistic_dwell/invalid_mate_parameters.scad)
 */
include <../../src/logistic_dwell/pair.scad>
curve_gear_logistic_dwell_mate(.8,34,3,4.8,gain=-1,samples=120);
