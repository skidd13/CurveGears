// Cassini family promotion of the circular tooth pipeline.
include <../../src/cassini/gear.scad>

$fn=96;
curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=240);
