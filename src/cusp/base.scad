/***
 * @module Cusp
 * @brief Hypocycloid cusp gears with radial cusp-tip teeth and a swept-envelope mate.
 *
 * The hypocycloid pitch curve has `cusps` equally spaced cusps (default 3),
 * so tooth count and samples must be divisible by `cusps`. A standard validated tooth profile is placed at
 * each cusp after being shifted inward to fit the local curve width. The mate
 * is generated from the complete placed driver outline and the closed motion
 * table. The pitch law is x=a*((cusps-1)*cos(t)+cos((cusps-1)*t)),
 * y=a*((cusps-1)*sin(t)-sin((cusps-1)*t)); perimeter is 8*a*(cusps-1).
 * Three cusps give the deltoid; five give a five-pointed hypocycloid.
 * Tooth count sets pitch spacing; ordinary teeth inaccessible beside cusp
 * tips or inside a cusp tooth's occupied shoulder interval are omitted.
 * Reference: https://mathworld.wolfram.com/Hypocycloid.html.
 * The public gear, body, mate, centre-distance, rotation, and pair APIs
 * are documented together below.
 */
include <../common/curve_gears_math.scad>
include <../common/mate/motion.scad>

/***
 * @function _cg_cusp_scale
 * @brief Scale the hypocycloid to the requested module and tooth count.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {number} Rolling-circle radius in millimetres.
 */
function _cg_cusp_scale(modul,tooth_number,cusps=3) =
    assert(cusps>=3 && floor(cusps)==cusps,"cusp_gear: cusps must be an integer >= 3")
    assert(tooth_number>=cusps && floor(tooth_number)==tooth_number && tooth_number%cusps==0,
        "cusp_gear: tooth_number must be an integer divisible by cusps")
    modul*tooth_number*_cg_circle_pi/(8*(cusps-1));
/***
 * @function _cg_cusp_points
 * @brief Sample one closed n-cusp hypocycloid pitch curve.
 * @param a {number > 0} Rolling-circle radius in millimetres.
 * @param samples {integer >= 3, divisible by cusps, default 720} Sample count.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array of points} Hypocycloid pitch curve in millimetres.
 */
function _cg_cusp_points(a,samples=720,cusps=3) =
    assert(cusps>=3 && floor(cusps)==cusps,"cusp_gear: cusps must be an integer >= 3")
    assert(samples>=cusps && floor(samples)==samples && samples%cusps==0,
        "cusp_gear: samples must be an integer divisible by cusps")
    [for(i=[0:samples-1])
        let(
            samples_per_lobe=samples/cusps,
            lobe=floor(i/samples_per_lobe),
            local_index=i-lobe*samples_per_lobe,
            local_arc=local_index/samples_per_lobe*(8*a*(cusps-1)/cusps),
            local_parameter=(2/cusps)*acos(1-cusps*local_arc/(4*a*(cusps-1))),
            t=360/cusps*lobe+local_parameter
        )
        [a*((cusps-1)*cos(t)+cos((cusps-1)*t)),a*((cusps-1)*sin(t)-sin((cusps-1)*t))]];
