/***
 * @function logistic_dwell_invalid_centre_distance_parameters
 * @brief Reject invalid curve controls consistently at the centre_distance entry point.
 * Source: [`logistic_dwell/invalid_centre_distance_parameters.scad`](logistic_dwell/invalid_centre_distance_parameters.scad)
 */
include <../../src/logistic_dwell/pair.scad>
echo(curve_gear_logistic_dwell_centre_distance(.8,34,gain=-1,samples=120));
cube(.01);
