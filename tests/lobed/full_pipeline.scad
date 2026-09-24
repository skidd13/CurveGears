include <../../src/lobed/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_lobed(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120);
translate([-35,0,0]) curve_gear_lobed_body(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120);
translate([35,0,0]) curve_gear_lobed_mate(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120);
translate([100,0,0]) curve_gear_lobed_pair(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120);
