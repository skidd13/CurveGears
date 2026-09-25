/***
 * @module Common Math
 * @brief Shared scalar, angle and vector helpers used by the geometry layers.
 *
 * These functions are internal implementation primitives and are not part of
 * the public family API.
 */
include <common_params.scad>

/*** @function _cg_degrees(angle)
 * @brief Convert radians to degrees.
 * @param angle {number} Angle in radians.
 * @return {number} Angle in degrees.
 */
function _cg_degrees(angle) = angle*_cg_deg_per_rad;
/*** @function _cg_radians(angle)
 * @brief Convert degrees to radians.
 * @param angle {number} Angle in degrees.
 * @return {number} Angle in radians.
 */
function _cg_radians(angle) = angle/_cg_deg_per_rad;
/*** @function _cg_polar(p)
 * @brief Convert a polar `[radius, angle]` pair to Cartesian coordinates.
 * @param p {array} Polar pair with angle in degrees.
 * @return {array} Cartesian point `[x, y]`.
 */
function _cg_polar(p) = [p[0]*cos(p[1]),p[0]*sin(p[1])];

/*** @function _cg_vsub(a, b)
 * @brief Subtract one two-dimensional vector from another.
 * @param a {array} Left-hand vector.
 * @param b {array} Right-hand vector.
 * @return {array} Difference vector.
 */
function _cg_vsub(a,b) = [a[0]-b[0], a[1]-b[1]];
/*** @function _cg_vlen(a)
 * @brief Calculate the Euclidean length of a two-dimensional vector.
 * @param a {array} Vector.
 * @return {number} Vector length.
 */
function _cg_vlen(a) = sqrt(a[0]*a[0] + a[1]*a[1]);
/*** @function _cg_vunit(a)
 * @brief Normalise a two-dimensional vector, returning zero for a zero vector.
 * @param a {array} Vector.
 * @return {array} Unit vector or `[0, 0]`.
 */
function _cg_vunit(a) = let(l=_cg_vlen(a)) l == 0 ? [0,0] : [a[0]/l,a[1]/l];
/*** @function _cg_lerp(a, b, t)
 * @brief Linearly interpolate between two scalar values.
 * @param a {number} Start value.
 * @param b {number} End value.
 * @param t {number} Interpolation fraction.
 * @return {number} Interpolated value.
 */
function _cg_lerp(a,b,t) = a + t*(b-a);
/*** @function _cg_vlerp(a, b, t)
 * @brief Linearly interpolate between two two-dimensional vectors.
 * @param a {array} Start vector.
 * @param b {array} End vector.
 * @param t {number} Interpolation fraction.
 * @return {array} Interpolated vector.
 */
function _cg_vlerp(a,b,t) = [_cg_lerp(a[0],b[0],t), _cg_lerp(a[1],b[1],t)];
/*** @function _cg_cross2(a, b)
 * @brief Calculate the scalar two-dimensional cross product.
 * @param a {array} First vector.
 * @param b {array} Second vector.
 * @return {number} Signed cross-product magnitude.
 */
function _cg_cross2(a,b) = a[0]*b[1]-a[1]*b[0];
/*** @function _cg_sum(v, i, acc)
 * @brief Sum a scalar array recursively.
 * @param v {array} Scalar values.
 * @param i {integer, default 0} Current index.
 * @param acc {number, default 0} Accumulated sum.
 * @return {number} Sum of the values.
 */
function _cg_sum(v,i=0,acc=0) = i >= len(v) ? acc : _cg_sum(v,i+1,acc+v[i]);
/*** @function _cg_prefix_sums(v, i, acc, out)
 * @brief Build inclusive prefix sums for a scalar array.
 * @param v {array} Scalar values.
 * @param i {integer, default 0} Current index.
 * @param acc {number, default 0} Accumulated sum.
 * @param out {array, default [0]} Prefix-sum output under construction.
 * @return {array} Prefix sums beginning with zero.
 */
function _cg_prefix_sums(v,i=0,acc=0,out=[0]) =
    i >= len(v) ? out : _cg_prefix_sums(v,i+1,acc+v[i],concat(out,[acc+v[i]]));

/*** @function _cg_closed_polyline_perimeter(points)
 * @brief Calculate the perimeter of a closed sampled point list.
 * @param points {array of points} Closed Cartesian polyline.
 * @return {number} Perimeter in the input coordinate units.
 */
function _cg_closed_polyline_perimeter(points) =
    _cg_sum([for(i=[0:len(points)-1])
        _cg_vlen(_cg_vsub(points[(i+1)%len(points)],points[i]))]);

/*** @function _cg_pitch_scale_from_points(modul, tooth_number, unit_points, circumference)
 * @brief Calculate pitch scaling from an existing unit-curve sample.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Requested tooth count.
 * @param unit_points {array of points} Closed unit-curve sample.
 * @param circumference {number > 0, default _cg_pi} Family-selected circumference constant.
 * @return {number} Scale factor for the sampled unit curve.
 */
function _cg_pitch_scale_from_points(modul,tooth_number,unit_points,circumference=_cg_pi) =
    circumference*modul*tooth_number/_cg_closed_polyline_perimeter(unit_points);

/*** @function _cg_scale_points(scale, points)
 * @brief Multiply every sampled point by one scalar.
 * @param scale {number} Point scale factor.
 * @param points {array of points} Cartesian point list.
 * @return {array of points} Scaled Cartesian point list.
 */
function _cg_scale_points(scale,points) = [for(p=points) [scale*p[0],scale*p[1]]];

/*** @function _cg_interp_x_for_y(tab, target, i)
 * @brief Interpolate an x value at a monotonic y target in a two-column table.
 * @param tab {array} Table of `[x, y]` samples.
 * @param target {number} Target y value.
 * @param i {integer, default 0} Search index.
 * @return {number} Interpolated x value.
 */
function _cg_interp_x_for_y(tab,target,i=0) =
    i >= len(tab)-1 ? tab[len(tab)-1][0] :
    (tab[i][1] <= target && tab[i+1][1] >= target && tab[i+1][1] > tab[i][1]
        ? let(y0=tab[i][1], y1=tab[i+1][1], f=(target-y0)/(y1-y0))
          _cg_lerp(tab[i][0],tab[i+1][0],f)
        : _cg_interp_x_for_y(tab,target,i+1));

/*** @function _cg_interp_y_for_x(tab, target, i)
 * @brief Interpolate a y value at a monotonic x target in a two-column table.
 * @param tab {array} Table of `[x, y]` samples.
 * @param target {number} Target x value.
 * @param i {integer, default 0} Search index.
 * @return {number} Interpolated y value.
 */
function _cg_interp_y_for_x(tab,target,i=0) =
    i >= len(tab)-1 ? tab[len(tab)-1][1] :
    (tab[i][0] <= target && tab[i+1][0] >= target && tab[i+1][0] > tab[i][0]
        ? let(x0=tab[i][0], x1=tab[i+1][0], f=(target-x0)/(x1-x0))
          _cg_lerp(tab[i][1],tab[i+1][1],f)
        : _cg_interp_y_for_x(tab,target,i+1));
/***
 * @module Mathematical References
 * @brief Mathematical sources used by the CurveGears families.
 * The ellipse uses the standard parametric ellipse. The lobed family uses a
 * sinusoidally modulated polar radius. The Pascal family uses Pascal's
 * limaçon. The logarithmic spiral follows the standard logarithmic spiral.
 * The epitrochoid follows the rolling-circle construction. The superformula
 * follows Johan Gielis, “A generic geometric transformation that unifies a
 * wide range of natural and abstract shapes”, American Journal of Botany
 * 90(3), 333–338 (2003), DOI 10.3732/ajb.90.3.333.
 * References: https://doi.org/10.3732/ajb.90.3.333
 * Pascal limaçon: https://mathworld.wolfram.com/Limacon.html
 * Logarithmic spiral: https://mathworld.wolfram.com/LogarithmicSpiral.html
 * Epitrochoid: https://mathworld.wolfram.com/Epitrochoid.html
 */
