/***
 * @function fourier_invalid_coefficients
 * @brief Deliberately non-positive-radius coefficient envelope.
 * Source: [`fourier/invalid_coefficients.scad`](fourier/invalid_coefficients.scad)
 */
include <../../src/fourier/gear.scad>
curve_gear_fourier(.8,34,4,4.8,[[2,.95,0]],samples=120);
