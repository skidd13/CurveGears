// Superformula family: high-curvature single-gear tooth placement.
include <../../src/superformula/gear.scad>

$fn=96;
curve_gear_superformula(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=360);
