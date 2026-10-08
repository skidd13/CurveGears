/***
 * @function invalid_backlash
 * @brief Reject unsupported backlash before tooth construction.
 * Source: [`circle/invalid_backlash.scad`](circle/invalid_backlash.scad)
 */
include <../../src/circle/gear.scad>
curve_gear_circle(.8,34,3,4.8,backlash=-.1);
