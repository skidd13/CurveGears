/***
 * @function invalid_body_width
 * @brief Reject non-positive Cusp body extrusion width.
 * Source: [`cusp/invalid_body_width.scad`](cusp/invalid_body_width.scad)
 */
include <../../src/cusp/gear.scad>
curve_gear_cusp_body(.8,36,-3,4.8);
