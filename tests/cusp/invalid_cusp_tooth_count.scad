/***
 * @function invalid_cusp_tooth_count
 * @brief Reject invalid cusp-count parameters before geometry construction.
 * Source: [`cusp/invalid_cusp_tooth_count.scad`](cusp/invalid_cusp_tooth_count.scad)
 */
include <../../src/cusp/pair.scad>
curve_gear_cusp_pair(.8,36,4,4.8,cusps=5);
