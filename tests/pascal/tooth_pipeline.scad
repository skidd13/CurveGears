// Pascal family: validate one non-convex body with the shared tooth pipeline.
include <../../src/pascal/gear.scad>

$fn=96;
curve_gear_pascal(.8,34,4,4.8,eccentricity=.68,samples=360);
