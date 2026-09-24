// Lobed family promotion after the circular and elliptical basis cases.
include <../../src/lobed/gear.scad>

$fn=96;
curve_gear_lobed(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120);
