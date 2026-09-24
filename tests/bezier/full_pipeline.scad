include <../../src/bezier/gear.scad>
$fn=48;
translate([-35,0,0]) curve_gear_bezier(.8,34,4,4.8,samples=360);
translate([35,0,0]) curve_gear_bezier_body(.8,34,4,4.8,samples=360);
