// Hypotrochoid family promotion of the circular tooth pipeline.
include <../../src/hypotrochoid/gear.scad>

$fn=96;
curve_gear_hypotrochoid(.8,34,4,4.8,samples=240);
