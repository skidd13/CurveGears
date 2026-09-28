/***
 * @module Circle
 * @brief Circular reference geometry for the canonical CurveGears family.
 *
 * Circle is the constant-radius reference family. Its public gear, body,
 * mate, centre-distance, and pair APIs provide the control case for the same
 * construction contracts used by the non-circular families.
 */
include <../common/curve_gears_math.scad>

/***
 * @function _cg_circle_radius(modul, tooth_number)
 * @brief Calculate the circular pitch radius from module and tooth count.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @return {number} Pitch radius in millimetres.
 */
function _cg_circle_radius(modul,tooth_number) = modul*tooth_number/2;
/***
 * @function _cg_circle_points(modul, tooth_number, samples=480)
 * @brief Sample the circular pitch curve in angular order.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param samples {integer >= 1, default 480} Number of pitch-curve samples.
 * @return {array of points} Closed circular pitch curve in millimetres.
 */
function _cg_circle_points(modul,tooth_number,samples=480) =
    let(radius=_cg_circle_radius(modul,tooth_number))
    [for(i=[0:samples-1]) [radius*cos(360*i/samples),radius*sin(360*i/samples)]];
