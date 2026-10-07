/***
 * @function invalid_cusp_count
 * @brief Reject invalid cusp-count parameters before geometry construction.
 * Source: [`cusp/invalid_cusp_count.scad`](cusp/invalid_cusp_count.scad)
 */
include <../../src/cusp/gear.scad>
curve_gear_cusp(.8,60,4,4.8,cusps=2);
