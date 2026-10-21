// @regression: expected-assertion fourier_gear: coefficients must be [positive_integer_harmonic, amplitude, phase] with sum(abs(amplitude)) < 0.9
/***
 * @function fourier_invalid_coefficients
 * @brief Deliberately non-positive-radius coefficient envelope.
 * Source: [`fourier/invalid_coefficients.scad`](fourier/invalid_coefficients.scad)
 */
include <../../src/fourier/gear.scad>
curve_gear_fourier(.8,34,4,4.8,[[2,.95,0]],samples=120);
