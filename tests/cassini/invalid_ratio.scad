/***
 * @function cassini_invalid_ratio
 * @brief Reject Cassini parameters outside the admissible radial range.
 * Source: [`cassini/invalid_ratio.scad`](cassini/invalid_ratio.scad)
 *
 * The lemniscate and two-loop regimes are outside the radial family contract.
 */
include <../../src/cassini/gear.scad>
curve_gear_cassini(.8,34,4,4.8,focus_ratio=1);
