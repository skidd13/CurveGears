include <../../src/fourier/gear.scad>
// Deliberately non-positive-radius coefficient envelope.
curve_gear_fourier(.8,34,4,4.8,[[2,.95,0]],samples=120);
