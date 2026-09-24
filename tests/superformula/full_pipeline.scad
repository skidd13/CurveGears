include <../../src/superformula/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_superformula(.8,34,4,4.8,symmetry=4,n1=2.4,n2=2.4,n3=2.4,samples=120);
translate([-35,0,0]) curve_gear_superformula_body(.8,34,4,4.8,symmetry=4,n1=2.4,n2=2.4,n3=2.4,samples=120);
translate([35,0,0]) curve_gear_superformula_mate(.8,34,4,4.8,symmetry=4,n1=2.4,n2=2.4,n3=2.4,samples=120);
translate([100,0,0]) curve_gear_superformula_pair(.8,34,4,4.8,symmetry=4,n1=2.4,n2=2.4,n3=2.4,samples=120);
