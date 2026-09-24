include <../../src/fourier/pair.scad>
$fn=48;
coefficients=[[2,.10,0],[3,.04,30]];
translate([-100,0,0]) curve_gear_fourier(.8,34,4,4.8,coefficients,samples=120);
translate([-35,0,0]) curve_gear_fourier_body(.8,34,4,4.8,coefficients,samples=120);
translate([35,0,0]) curve_gear_fourier_mate(.8,34,4,4.8,coefficients,samples=120);
translate([100,0,0]) curve_gear_fourier_pair(.8,34,4,4.8,coefficients,samples=120);
