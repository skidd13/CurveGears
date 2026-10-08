/***
 * @function invalid_body_bore
 * @brief Reject a negative Cusp body bore.
 * Source: [`cusp/invalid_body_bore.scad`](cusp/invalid_body_bore.scad)
 */
include <../../src/cusp/gear.scad>
curve_gear_cusp_body(.8,36,3,-1);
