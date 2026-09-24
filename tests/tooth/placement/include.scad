/***
 * @function tooth_placement_include
 * @brief Direct include smoke test for the standalone tooth-placement layer.
 * Source: [`tooth/placement/include.scad`](tooth/placement/include.scad)
 */
include <../../../src/tooth/placement.scad>

$fn=48;
modul=.8;
tooth_number=34;
pitch_radius=modul*tooth_number/2;
samples=48;
points=[for(i=[0:samples-1]) [pitch_radius*cos(360*i/samples),pitch_radius*sin(360*i/samples)]];
arc=_cg_polyline_arc_table(points);
perimeter=arc[len(arc)-1][1];
frame=_cg_local_frame_for_closed_arc(points,arc,perimeter,0);
assert(_cg_frame_valid(frame),str("standalone tooth placement frame failed: ",_cg_frame_failure_code(frame)));
assert(_cg_frame_continuity_failure_code(points,arc,perimeter,0,perimeter/tooth_number)=="PASS","standalone frame continuity failed");
cube([1,1,4]);
