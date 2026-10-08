/***
 * @function invalid_body_bore_2d
 * @brief Reject a negative planar Cusp body bore.
 * Source: [`cusp/invalid_body_bore_2d.scad`](cusp/invalid_body_bore_2d.scad)
 */
include <../../src/cusp/gear.scad>
curve_gear_cusp_body_2d(.8,36,-1);
