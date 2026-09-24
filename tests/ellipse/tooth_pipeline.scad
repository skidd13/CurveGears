// Ellipse family promotion of the circular tooth pipeline.
include <../../src/ellipse/gear.scad>

$fn=96;
curve_gear_ellipse(.8,34,4,4.8,eccentricity=.72,samples=120);
