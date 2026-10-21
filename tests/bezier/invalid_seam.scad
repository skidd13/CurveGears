// @regression: expected-assertion bezier_gear: control points must form closed cubic segments with forward tangent continuity
/***
 * @function bezier_invalid_seam
 * @brief Deliberately non-collinear tangent at the closing Bézier seam.
 * Source: [`bezier/invalid_seam.scad`](bezier/invalid_seam.scad)
 */
include <../../src/bezier/gear.scad>
c=_cg_bezier_default_control_points;
bad=[for(i=[0:len(c)-1]) i==1 ? [1.2,.5523] : c[i]];
curve_gear_bezier(.8,34,4,4.8,control_points=bad,samples=120);
