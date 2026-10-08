/***
 * @function invalid_backlash_upper
 * @brief Reject unsupported backlash before tooth construction.
 * Source: [`circle/invalid_backlash_upper.scad`](circle/invalid_backlash_upper.scad)
 */
include <../../src/circle/gear.scad>
curve_gear_circle(.8,34,3,4.8,backlash=2);
