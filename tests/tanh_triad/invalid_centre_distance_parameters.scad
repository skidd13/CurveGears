/***
 * @function tanh_triad_invalid_centre_distance_parameters
 * @brief Reject invalid curve controls consistently at the centre_distance entry point.
 * Source: [`tanh_triad/invalid_centre_distance_parameters.scad`](tanh_triad/invalid_centre_distance_parameters.scad)
 */
include <../../src/tanh_triad/pair.scad>
echo(curve_gear_tanh_triad_centre_distance(.8,34,transition=-1,samples=120));
cube(.01);
