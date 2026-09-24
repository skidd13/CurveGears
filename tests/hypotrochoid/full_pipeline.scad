// Hypotrochoid family full maintained-entry-point render.
include <../../src/hypotrochoid/gear.scad>
include <../../src/hypotrochoid/mate.scad>
include <../../src/hypotrochoid/pair.scad>

$fn=96;
translate([-110,0,0]) curve_gear_hypotrochoid(.8,34,4,4.8,samples=240);
translate([-35,0,0]) curve_gear_hypotrochoid_body(.8,34,4,4.8,samples=240);
translate([35,0,0]) curve_gear_hypotrochoid_mate(.8,34,4,4.8,samples=240);
translate([110,0,0]) curve_gear_hypotrochoid_pair(.8,34,4,4.8,samples=240,together_built=false);
