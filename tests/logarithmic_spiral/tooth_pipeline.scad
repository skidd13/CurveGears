// Logarithmic-spiral family: radial return segments must omit inaccessible teeth.
include <../../src/logarithmic_spiral/gear.scad>

$fn=96;
curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120);
