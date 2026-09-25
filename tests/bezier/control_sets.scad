/***
 * @function bezier_control_sets
 * @brief Verify Bézier control sets preserve closure and admissible sampling.
 * Source: [`bezier/control_sets.scad`](bezier/control_sets.scad)
 */
include <../../src/bezier/gear.scad>
$fn=48;
circle_controls=[[1,0],[1,.5523],[.5523,1],[0,1],[-.5523,1],[-1,.5523],[-1,0],[-1,-.5523],[-.5523,-1],[0,-1],[.5523,-1],[1,-.5523],[1,0]];
oval_controls=[[1.15,0],[1.15,.634],[.634,1],[0,1],[-.634,1],[-1.15,.634],[-1.15,0],[-1.15,-.634],[-.634,-1],[0,-1],[.634,-1],[1.15,-.634],[1.15,0]];
function _cg_reference_bezier_point(p0,p1,p2,p3,t) =
    [pow(1-t,3)*p0[0]+3*pow(1-t,2)*t*p1[0]+3*(1-t)*t*t*p2[0]+t*t*t*p3[0],
     pow(1-t,3)*p0[1]+3*pow(1-t,2)*t*p1[1]+3*(1-t)*t*t*p2[1]+t*t*t*p3[1]];
assert(max([for(s=[0:3],i=[0:100])
    let(j=3*s,t=i/100,
        actual=_cg_bezier_point(circle_controls[j],circle_controls[j+1],circle_controls[j+2],circle_controls[j+3],t),
        reference=_cg_reference_bezier_point(circle_controls[j],circle_controls[j+1],circle_controls[j+2],circle_controls[j+3],t))
    _cg_vlen(_cg_vsub(actual,reference))])<1e-7,"Bézier basis reuse exceeded geometry tolerance");
translate([-45,0,0]) curve_gear_bezier(.8,34,4,4.8,control_points=circle_controls,samples=360);
translate([45,0,0]) curve_gear_bezier(.8,34,4,4.8,control_points=oval_controls,samples=360);
