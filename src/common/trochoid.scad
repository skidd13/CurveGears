/***
 * @module Trochoid common
 * @brief Private shared geometry for rolling-circle trochoid families.
 *
 * This file is an implementation detail. Public family APIs live in
 * `epitrochoid/` and `hypotrochoid/`; the rolling equations remain in those
 * family modules. This layer contains only the shared curve post-processing.
 */
include <curve_gears_math.scad>

/** @function _cg_trochoid_scale_from_points
 * @brief Scale a sampled unit curve to the requested tooth pitch.
 */
function _cg_trochoid_scale_from_points(modul,tooth_number,points) =
    _cg_pitch_scale_from_points(modul,tooth_number,points,_cg_circle_pi);

/** @function _cg_trochoid_radius_from_point
 * @brief Evaluate the radial distance of a unit-curve point.
 */
function _cg_trochoid_radius_from_point(point) = _cg_vlen(point);
/** @function _cg_trochoid_curve_radius_from_point
 * @brief Evaluate the radial distance of a scaled curve point.
 */
function _cg_trochoid_curve_radius_from_point(scale,point) = scale*_cg_trochoid_radius_from_point(point);
/** @function _cg_trochoid_points_scaled_from_points
 * @brief Scale sampled unit-curve points.
 */
function _cg_trochoid_points_scaled_from_points(scale,points) = _cg_scale_points(scale,points);

/**
 * @function _cg_trochoid_shape
 * @brief Bind a sampled trochoid polygon to the shared physical-angle shape contract.
 * @param unit_points {array of 2D points} Unit-scale driver polygon.
 * @param scale {number > 0} Perimeter-derived physical scale.
 * @param lower {number} Solver lower bound.
 * @param upper {number} Solver upper bound.
 * @param radial_root {boolean, default false} Use radial-root tooth placement.
 * @return {array} `[driver points, physical radius function, lower, upper, radial_root]`.
 */
function _cg_trochoid_shape(unit_points,scale,lower,upper,radial_root=false) =
    let(points=_cg_trochoid_points_scaled_from_points(scale,unit_points),table=_cg_trochoid_polar_table(points))
    [points,function(theta) _cg_trochoid_radius_at_polar_angle(table,theta),lower,upper,radial_root];

/**
 * @function _cg_trochoid_polar_table(points)
 * @brief Index a finite star-shaped driver polygon by monotonically increasing physical polar angle.
 * @param points {array of 2D points} Closed polygon starting on the positive X ray.
 * @return {array} Angle/point rows with an explicit closing row at 360 degrees.
 */
function _cg_trochoid_polar_table(points) =
    assert(len(points)>=3 && _cg_polyline_finite(points),"trochoid_mate: pitch points must be finite")
    let(angles=[for(p=points) let(a=atan2(p[1],p[0])) a<0 ? a+360 : a])
    assert(abs(angles[0])<=_cg_eps_angle() && min([for(p=points) _cg_vlen(p)])>_cg_eps_len(),
        "trochoid_mate: pitch curve must start on the positive X ray and avoid the origin")
    assert(min([for(i=[0:len(points)-2]) angles[i+1]>angles[i]+_cg_eps_angle() ? 1 : 0])==1,
        "trochoid_mate: pitch curve must have monotonic polar traversal")
    concat([for(i=[0:len(points)-1]) [angles[i],points[i]]],[[360,points[0]]]);

/**
 * @function _cg_trochoid_radius_at_polar_angle(table, theta)
 * @brief Intersect a physical polar ray with the indexed polygon segment, without interpolating curve parameters.
 * @param table {array} Validated angle/point table.
 * @param theta {angle} Physical polar angle in degrees.
 * @return {number} Radius of the exact sampled driver polygon at that angle.
 */
function _cg_trochoid_radius_at_polar_angle(table,theta) =
    let(wrapped=theta-360*floor(theta/360),
        i=min(len(table)-2,_cg_upper_bound_column(table,wrapped,0,0,len(table)-1)),
        a=table[i][1],b=table[i+1][1],direction=[cos(wrapped),sin(wrapped)],
        denominator=_cg_cross2(direction,_cg_vsub(b,a)))
    assert(denominator>0,"trochoid_mate: degenerate polar segment")
    _cg_cross2(a,b)/denominator;

/**
 * @function _cg_trochoid_polar_radii(points, n, midpoint=false)
 * @brief Sample the emitted driver polygon at uniformly spaced physical polar angles.
 * @param points {array of 2D points} Closed star-shaped driver polygon.
 * @param n {integer >= 3} Number of motion intervals.
 * @param midpoint {boolean, default false} Use integration midpoints instead of phase boundaries.
 * @return {array of number} Physical pitch radii in increasing angular order.
 */
function _cg_trochoid_polar_radii(points,n,midpoint=false) =
    assert(n>=3 && floor(n)==n,"trochoid_mate: motion samples must be an integer >= 3")
    let(table=_cg_trochoid_polar_table(points))
    [for(i=[0:n-1]) _cg_trochoid_radius_at_polar_angle(table,360*(i+(midpoint ? .5 : 0))/n)];
