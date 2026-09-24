include <../../src/fourier/gear.scad>
$fn=48;
translate([-45,0,0]) curve_gear_fourier(.8,34,4,4.8,[[2,.10,0]],samples=120);
translate([45,0,0]) curve_gear_fourier(.8,34,4,4.8,[[2,.10,0],[5,.06,18]],samples=120);
