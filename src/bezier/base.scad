/***
 * @module Bezier
 * @brief Closed cubic Bézier pitch curves with explicit continuity checks.
 * Control points are supplied in groups of three per segment:
 * [start, handle, handle, end, handle, handle, end, ...]. The final point
 * must equal the first point. Join tangents must be collinear and forward;
 * this prevents a hidden corner from entering the tooth sampler.
 * The cubic curve is exact between controls; the gear boundary uses a sampled
 * polyline for OpenSCAD polygon construction. Dense sampling is required for
 * sharp curvature, and arbitrary Cartesian controls are not promised to be a
 * single-valued radial pitch curve.
 *
 * The basic curve is `B(t)=(1-t)^3 P0+3(1-t)^2 t P1+3(1-t)t^2 P2+t^3 P3`,
 * for `0 <= t <= 1`. Reference:
 * https://www.cs.sjsu.edu/~bruce/fall_2016_cs_116a_lecture_splines.html.
 */
include <../common/curve_gears_math.scad>

_cg_bezier_default_control_points=[[1,0],[1,.5523],[.5523,1],[0,1],[-.5523,1],[-1,.5523],[-1,0],[-1,-.5523],[-.5523,-1],[0,-1],[.5523,-1],[1,-.5523],[1,0]];

/**
 * @function _cg_bezier_segment_count
 * @brief Return the number of cubic segments in a closed control-point list.
 * @param control_points {array of points} Closed Bézier control-point list.
 * @return {integer} Number of cubic segments.
 */
function _cg_bezier_segment_count(control_points) = (len(control_points)-1)/3;

/**
 * @function _cg_bezier_point
 * @brief Evaluate one cubic Bézier segment.
 * @param p0 {point} Segment start point.
 * @param p1 {point} First control point.
 * @param p2 {point} Second control point.
 * @param p3 {point} Segment end point.
 * @param t {number, 0 <= t <= 1} Segment interpolation parameter.
 * @return {point} Evaluated Cartesian point.
 */
function _cg_bezier_point(p0,p1,p2,p3,t) =
    let(u=1-t,u2=u*u,t2=t*t,b0=u2*u,b1=3*u2*t,b2=3*u*t2,b3=t2*t)
    [b0*p0[0]+b1*p1[0]+b2*p2[0]+b3*p3[0],
     b0*p0[1]+b1*p1[1]+b2*p2[1]+b3*p3[1]];

/**
 * @function _cg_bezier_controls_valid
 * @brief Validate closure, segment grouping and forward tangent continuity.
 * @param control_points {array of points} Closed Bézier control-point list.
 * @return {boolean} True when the control list is structurally valid.
 */
function _cg_bezier_controls_valid(control_points) =
    len(control_points)>=7
    && (len(control_points)-1)%3==0
    && _cg_vlen(_cg_vsub(control_points[0],control_points[len(control_points)-1]))<=1e-6
    && min([for(i=[1:_cg_bezier_segment_count(control_points)-1])
        let(j=3*i,incoming=_cg_vsub(control_points[j],control_points[j-1]),outgoing=_cg_vsub(control_points[j+1],control_points[j]))
        _cg_vlen(incoming)>1e-6 && _cg_vlen(outgoing)>1e-6 && abs(_cg_cross2(incoming,outgoing))<=1e-5 && incoming[0]*outgoing[0]+incoming[1]*outgoing[1]>0 ? 1 : 0])==1;

/**
 * @function _cg_bezier_points
 * @brief Sample a closed Bézier pitch curve into the shared tooth engine.
 * @param control_points {array of points} Valid closed Bézier control-point list.
 * @param scale {number > 0} Radial scale applied to each sampled point.
 * @param samples {integer >= 1} Number of output samples.
 * @return {array of points} Sampled Cartesian pitch points.
 */
function _cg_bezier_points(control_points,scale,samples) =
    let(segments=_cg_bezier_segment_count(control_points))
    [for(i=[0:samples-1])
        let(u=i*segments/samples,s=min(segments-1,floor(u)),t=u-floor(u),j=3*s,p=_cg_bezier_point(control_points[j],control_points[j+1],control_points[j+2],control_points[j+3],t))
        [scale*p[0],scale*p[1]]];

module _cg_bezier_build(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false) {
/***
 * @function _cg_bezier_build(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)
 * @brief Internal bezier construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param control_points {value, default _cg_bezier_default_control_points} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(modul>0 && width>0 && bore>=0,"bezier_gear: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"bezier_gear: tooth_number must be an integer >= 3");
    assert(_cg_bezier_controls_valid(control_points),"bezier_gear: control points must form closed cubic segments with forward tangent continuity");
    assert(samples>=120 && floor(samples)==samples,"bezier_gear: samples must be an integer >= 120");
    scale=modul*tooth_number/2;
    points=_cg_bezier_points(control_points,scale,samples);
    rotate([0,0,orientation]) _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

/***
 * @function curve_gear_bezier(modul, tooth_number, width, bore, ...)
 * @brief Build a closed cubic Bézier gear from user-controlled normalised points.
 * @image ../images/functions/bezier/curve_gear_bezier.png Bézier gear preview
 * @image ../images/functions/bezier/curve_gear_bezier_alternative.png Bézier asymmetric alternative
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param control_points {closed array grouped as 3n+1 points} Segment endpoints and handles; final point must equal first.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_bezier(1, 24, 4, 8);
 */
module curve_gear_bezier(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_bezier_build(modul,tooth_number,width,bore,control_points,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_bezier_body(modul, tooth_number, width, bore, ...)
 * @brief Build the closed Bézier body without teeth.
 * @image ../images/functions/bezier/curve_gear_bezier_body.png Bézier body preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param control_points {closed array grouped as 3n+1 points} Segment endpoints and handles; final point must equal first.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 */
module curve_gear_bezier_body(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_bezier_build(modul,tooth_number,width,bore,control_points,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}
