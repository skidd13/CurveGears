// Public circle family contract: gear, mate, and pair.
include <../../src/circle/gear.scad>
include <../../src/circle/mate.scad>
include <../../src/circle/pair.scad>

$fn=96;
translate([-35,0,0]) curve_gear_circle(.8,34,4,4.8,samples=240);
translate([-12,0,0]) curve_gear_circle_body(.8,34,4,4.8,samples=240);
translate([12,0,0]) curve_gear_circle_mate(.8,34,4,4.8,samples=240);
translate([35,0,0]) curve_gear_circle_pair(.8,34,4,4.8,samples=240,together_built=false);
