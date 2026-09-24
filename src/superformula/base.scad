/***
 * @module Superformula
 * @brief Gielis superformula geometry for non-circular gears.
 *
 * The basic radial curve is `r=(|cos(m theta/4)/a|^n2 +
 * |sin(m theta/4)/b|^n3)^(-1/n1)`. Odd symmetry requires `a=b` and `n2=n3`
 * for full-turn continuity; sharp or concave profiles require sufficient
 * sampling and clearance. Reference: https://pubmed.ncbi.nlm.nih.gov/21659124/.
 */
include <../common/curve_gears_math.scad>

// Johan Gielis, A generic geometric transformation that unifies a wide range of natural and abstract shapes, American Journal of Botany 90 (2003), 333–338.
/***
 * @function _cg_superformula_unit_radius(symmetry, a, b, n1, n2, n3, theta)
 * @brief Evaluate the unit Gielis superformula radius.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Unit radius.
 */
function _cg_superformula_unit_radius(symmetry,a,b,n1,n2,n3,theta) =
    pow(
        pow(abs(cos(symmetry*theta/4)/a),n2) +
        pow(abs(sin(symmetry*theta/4)/b),n3),
        -1/n1
    );
/***
 * @function _cg_superformula_point(scale, symmetry, a, b, n1, n2, n3, theta)
 * @brief Evaluate one Cartesian point on a scaled superformula curve.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param theta {angle} Polar angle in degrees.
 * @return {array} Cartesian point `[x, y]` in mm.
 */
function _cg_superformula_point(scale,symmetry,a,b,n1,n2,n3,theta) =
    let(r=scale*_cg_superformula_unit_radius(symmetry,a,b,n1,n2,n3,theta)) [r*cos(theta),r*sin(theta)];
/***
 * @function _cg_superformula_points(scale, symmetry, a, b, n1, n2, n3, n)
 * @brief Sample a complete scaled superformula pitch curve.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param n {integer >= 1, default 360} Number of samples.
 * @return {array} Closed list of sampled Cartesian points.
 */
function _cg_superformula_points(scale,symmetry,a,b,n1,n2,n3,n=360) =
    [for(i=[0:n-1]) _cg_superformula_point(scale,symmetry,a,b,n1,n2,n3,360*i/n)];
/***
 * @function _cg_superformula_scale(modul, tooth_number, symmetry, a, b, n1, n2, n3, n)
 * @brief Scale a superformula curve to the requested tooth pitch.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param n {integer >= 1, default 360} Number of samples used for arc length.
 * @return {number} Mean pitch-radius scale in mm.
 */
function _cg_superformula_scale(modul,tooth_number,symmetry,a,b,n1,n2,n3,n=360) =
    let(points=_cg_superformula_points(1,symmetry,a,b,n1,n2,n3,n),arc=_cg_polyline_arc_table(points),P=arc[len(arc)-1][1])
    _cg_pi*modul*tooth_number/P;
/***
 * @function _cg_superformula_radius(scale, symmetry, a, b, n1, n2, n3, theta)
 * @brief Evaluate a scaled superformula radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Radius in mm.
 */
function _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,theta) = scale*_cg_superformula_unit_radius(symmetry,a,b,n1,n2,n3,theta);
/***
 * @function _cg_superformula_max_radius(scale, symmetry, a, b, n1, n2, n3, n)
 * @brief Find the maximum sampled radius of a superformula curve.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param n {integer >= 1, default 360} Number of samples.
 * @return {number} Maximum sampled radius in mm.
 */
function _cg_superformula_max_radius(scale,symmetry,a,b,n1,n2,n3,n=360) =
    max([for(i=[0:n-1]) _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,360*i/n)]);
/***
 * @function _cg_superformula_odd_valid(symmetry, a, b, n2, n3, tol)
 * @brief Check the continuity constraints for odd superformula symmetry.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial scale factor.
 * @param b {number > 0} Superformula radial scale factor.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param tol {number > 0, default 1e-9} Comparison tolerance.
 * @return {boolean} True when the odd-symmetry continuity condition holds.
 */
function _cg_superformula_odd_valid(symmetry,a,b,n2,n3,tol=1e-9) =
    symmetry%2==0 || (abs(a-b)<=tol && abs(n2-n3)<=tol);
