/***
 * @function bezier_invalid_tangent
 * @brief Deliberately zero incoming tangent at the segment join.
 * Source: [`bezier/invalid_tangent.scad`](bezier/invalid_tangent.scad)
 */
include <../../src/bezier/gear.scad>
curve_gear_bezier(.8,34,4,4.8,control_points=[[1,0],[1,.5],[0,1],[0,1],[-.5,1],[-1,0],[1,0]],samples=120);
