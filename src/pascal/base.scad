/***
 * @module Pascal
 * @brief Pascal limaçon geometry for non-circular gears.
 *
 * The pitch curve is `r(theta)=s(1+e cos(theta))`. Eccentricity at or above
 * roughly 0.5 is non-convex and is intended for deliberate experimental use;
 * the bore must remain below the minimum pitch radius. Reference:
 * https://mathshistory.st-andrews.ac.uk/Curves/Limacon/.
 */
include <../common/curve_gears_math.scad>

// Pascal limaçon: r=s(1+e cosθ). Non-convex cases remain experimental.
/***
 * @function _cg_pascal_unit_radius(eccentricity, phi)
 * @brief Evaluate the unit radial form of the Pascal limaçon.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @param phi {angle} Polar angle in degrees.
 * @return {number} Unit radius at the requested angle.
 */
function _cg_pascal_unit_radius(eccentricity,phi) = 1+eccentricity*cos(phi);
/***
 * @function _cg_pascal_point(scale, eccentricity, phi)
 * @brief Evaluate one Cartesian point on a scaled Pascal curve.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @param phi {angle} Polar angle in degrees.
 * @return {array} Cartesian point `[x, y]` in mm.
 */
function _cg_pascal_point(scale,eccentricity,phi) = let(r=scale*_cg_pascal_unit_radius(eccentricity,phi)) [r*cos(phi),r*sin(phi)];
/***
 * @function _cg_pascal_points(scale, eccentricity, n)
 * @brief Sample one complete Pascal pitch curve.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @param n {integer >= 1, default 720} Number of samples.
 * @return {array} Closed list of sampled Cartesian points.
 */
function _cg_pascal_points(scale,eccentricity,n=720) = [for(i=[0:n-1]) _cg_pascal_point(scale,eccentricity,360*i/n)];
/***
 * @function _cg_pascal_scale(modul, tooth_number, eccentricity, n)
 * @brief Scale a Pascal curve to the requested tooth pitch.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @param n {integer >= 1, default 720} Number of samples used for arc length.
 * @return {number} Mean pitch-radius scale in mm.
 */
function _cg_pascal_scale(modul,tooth_number,eccentricity,n=720) =
    let(points=_cg_pascal_points(1,eccentricity,n),arc=_cg_polyline_arc_table(points),P=arc[len(arc)-1][1])
    _cg_pi*modul*tooth_number/P;
/***
 * @function _cg_pascal_radius(scale, eccentricity, phi)
 * @brief Evaluate a scaled Pascal pitch-curve radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @param phi {angle} Polar angle in degrees.
 * @return {number} Radius in mm.
 */
function _cg_pascal_radius(scale,eccentricity,phi) = scale*_cg_pascal_unit_radius(eccentricity,phi);
/***
 * @function _cg_pascal_min_radius(scale, eccentricity)
 * @brief Calculate the minimum Pascal pitch-curve radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {number} Minimum radius in mm.
 */
function _cg_pascal_min_radius(scale,eccentricity) = scale*(1-eccentricity);
/***
 * @function _cg_pascal_max_radius(scale, eccentricity)
 * @brief Calculate the maximum Pascal pitch-curve radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {number} Maximum radius in mm.
 */
function _cg_pascal_max_radius(scale,eccentricity) = scale*(1+eccentricity);
/***
 * @function _cg_pascal_centre_distance(scale, eccentricity)
 * @brief Calculate the mathematical Pascal pair centre distance.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {number} Pair centre distance in mm.
 */
function _cg_pascal_centre_distance(scale,eccentricity) = scale*(4+2*sqrt(1+3*eccentricity*eccentricity))/3;
/***
 * @function _cg_pascal_requires_radial_root(eccentricity)
 * @brief Determine whether the Pascal curve requires radial-root tooth construction.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {boolean} True when the non-convex threshold is reached.
 */
function _cg_pascal_requires_radial_root(eccentricity) = eccentricity >= 0.5;
