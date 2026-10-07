/***
 * @function invalid_fractional_cusps
 * @brief Reject a non-integer cusp count.
 * Source: [`cusp/invalid_fractional_cusps.scad`](cusp/invalid_fractional_cusps.scad)
 */
include <../../src/cusp/gear.scad>
curve_gear_cusp(.8,60,4,4.8,cusps=4.5);
