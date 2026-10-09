/***
 * @function temple_fay_invalid_pair_samples
 * @brief Retain the minimum 120-sample requirement for dynamic pair construction.
 * Source: [`temple_fay/invalid_pair_samples.scad`](temple_fay/invalid_pair_samples.scad)
 */
include <../../src/temple_fay/pair.scad>
curve_gear_temple_fay_pair(.8,34,1,4.8,samples=12);
