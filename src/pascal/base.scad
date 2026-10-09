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
include <../common/harmonic.scad>

/***
 * @function _cg_pascal_unit_radius
 * @brief Evaluate the unit radial form r=s(1+e cos(phi)) of the Pascal limaçon; non-convex cases remain experimental.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @param phi {angle} Polar angle in degrees.
 * @return {number} Unit radius at the requested angle.
 */
function _cg_pascal_unit_radius(eccentricity,phi) = _cg_harmonic_unit_radius([[1,eccentricity,0]],phi);
function _cg_pascal_shape(modul,tooth_number,eccentricity=.25,samples=720) =
    _cg_polar_shape(
        function(theta) _cg_pascal_unit_radius(eccentricity,theta),
        modul,tooth_number,samples,
        function(scale) let(mx=scale*(1+eccentricity)) [mx+.01,4*mx],
        _cg_pascal_requires_radial_root(eccentricity));
/***
 * @function _cg_pascal_min_radius
 * @brief Calculate the minimum Pascal pitch-curve radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {number} Minimum radius in mm.
 */
function _cg_pascal_min_radius(scale,eccentricity) = scale*(1-eccentricity);
/***
 * @function _cg_pascal_max_radius
 * @brief Calculate the maximum Pascal pitch-curve radius.
 * @param scale {number > 0} Mean pitch-radius scale in mm.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {number} Maximum radius in mm.
 */
function _cg_pascal_max_radius(scale,eccentricity) = scale*(1+eccentricity);
/***
 * @function _cg_pascal_requires_radial_root
 * @brief Determine whether the Pascal curve requires radial-root tooth construction.
 * @param eccentricity {0 <= e < 1} Pascal curve eccentricity.
 * @return {boolean} True when the non-convex threshold is reached.
 */
function _cg_pascal_requires_radial_root(eccentricity) = eccentricity >= 0.5;
