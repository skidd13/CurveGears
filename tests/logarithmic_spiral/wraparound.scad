/***
 * @function logarithmic_spiral_wraparound
 * @brief Nautilus wraparound: the final/first placement boundary is exercised with
 * Source: [`logarithmic_spiral/wraparound.scad`](logarithmic_spiral/wraparound.scad)
 *
 * a phase near one full turn and the radial return remains canonical.
 */
include <../../src/logarithmic_spiral/gear.scad>

$fn=96;
curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,
    tooth_phase=359,samples=240);
