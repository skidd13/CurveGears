// Cassini family: common pair assembly plus standalone mate API.
include <../../src/cassini/pair.scad>

$fn=96;
curve_gear_cassini_pair(.8,34,4,4.8,focus_ratio=.78,samples=240,phase=17,backlash=.02,clearance=.01);
translate([70,0,0])
    curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.78,samples=240,backlash=.02,clearance=.01);
