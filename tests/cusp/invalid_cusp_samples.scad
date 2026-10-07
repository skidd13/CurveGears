/***
 * @function invalid_cusp_samples
 * @brief Reject invalid cusp-count parameters before geometry construction.
 * Source: [`cusp/invalid_cusp_samples.scad`](cusp/invalid_cusp_samples.scad)
 */
include <../../src/cusp/mate.scad>
curve_gear_cusp_mate(.8,60,4,4.8,samples=721,cusps=5);
