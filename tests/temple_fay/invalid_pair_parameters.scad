/***
 * @function temple_fay_invalid_pair_parameters
 * @brief Retain rejection of invalid curve controls at the dynamic pair entry point.
 * Source: [`temple_fay/invalid_pair_parameters.scad`](temple_fay/invalid_pair_parameters.scad)
 */
include <../../src/temple_fay/pair.scad>
curve_gear_temple_fay_pair(.8,34,1,4.8,wing=-.1,samples=120);
