include <../../src/logarithmic_spiral/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120);
translate([-35,0,0]) curve_gear_logarithmic_spiral_body(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120);
translate([35,0,0]) curve_gear_logarithmic_spiral_mate(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120);
translate([100,0,0]) curve_gear_logarithmic_spiral_pair(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120);
