include <../../src/bezier/gear.scad>
$fn=48;
circle_controls=[[1,0],[1,.5523],[.5523,1],[0,1],[-.5523,1],[-1,.5523],[-1,0],[-1,-.5523],[-.5523,-1],[0,-1],[.5523,-1],[1,-.5523],[1,0]];
oval_controls=[[1.15,0],[1.15,.634],[.634,1],[0,1],[-.634,1],[-1.15,.634],[-1.15,0],[-1.15,-.634],[-.634,-1],[0,-1],[.634,-1],[1.15,-.634],[1.15,0]];
translate([-45,0,0]) curve_gear_bezier(.8,34,4,4.8,control_points=circle_controls,samples=360);
translate([45,0,0]) curve_gear_bezier(.8,34,4,4.8,control_points=oval_controls,samples=360);
