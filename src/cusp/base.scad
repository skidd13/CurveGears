/***
 * @module Cusp
 * @brief Three-cusp deltoid gears with radial cusp-tip teeth and a swept-envelope mate.
 *
 * The deltoid pitch curve has three equally spaced cusps, so the tooth count
 * must be divisible by three. A standard validated tooth profile is placed at
 * each cusp after being shifted inward to fit the local curve width. The mate
 * is generated from the complete placed driver outline and the closed motion
 * table. The public gear, body, mate, centre-distance, rotation, and pair APIs
 * are documented together below.
 */
include <../common/curve_gears_math.scad>
include <../mate/motion.scad>

/***
 * @function _cg_cusp_scale(modul, tooth_number)
 * @brief Scale the deltoid to the requested module and tooth count.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by 3} Number of teeth.
 * @return {number} Deltoid scale in millimetres.
 */
function _cg_cusp_scale(modul,tooth_number) = modul*tooth_number*_cg_circle_pi/16;
/***
 * @function _cg_cusp_points(a, samples=720)
 * @brief Sample one closed three-cusp deltoid pitch curve.
 * @param a {number > 0} Deltoid scale in millimetres.
 * @param samples {integer >= 3, divisible by 3, default 720} Sample count.
 * @return {array of points} Deltoid pitch curve in millimetres.
 */
function _cg_cusp_points(a,samples=720) =
    [for(i=[0:samples-1])
        let(
            samples_per_lobe=samples/3,
            lobe=floor(i/samples_per_lobe),
            local_index=i-lobe*samples_per_lobe,
            local_arc=local_index/samples_per_lobe*(16*a/3),
            local_parameter=(2/3)*acos(1-3*local_arc/(8*a)),
            t=120*lobe+local_parameter
        )
        [a*(2*cos(t)+cos(2*t)),a*(2*sin(t)-sin(2*t))]];
