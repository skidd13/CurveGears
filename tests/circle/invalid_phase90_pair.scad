// @regression: expected-assertion MATE_TOOTH_GAP_INSUFFICIENT
/***
 * @function circle_invalid_phase90_pair
 * @brief Reject the measured overlap in a phase-shifted Circle gear pair.
 * Source: [`circle/invalid_phase90_pair.scad`](circle/invalid_phase90_pair.scad)
 */
include <../../src/circle/pair.scad>
curve_gear_circle_pair(.8,34,4,0,samples=120,tooth_phase=90);
