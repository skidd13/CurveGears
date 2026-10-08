/***
 * @function invalid_backlash_2d
 * @brief Reject unsupported backlash before tooth construction.
 * Source: [`circle/invalid_backlash_2d.scad`](circle/invalid_backlash_2d.scad)
 */
include <../../src/circle/gear.scad>
curve_gear_circle_2d(.8,34,4.8,backlash=-.1);
