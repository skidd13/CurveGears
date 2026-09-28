/***
 * @module Cusp
 * @brief Three-cusp deltoid pitch geometry and conjugate motion equations.
 */
include <../common/curve_gears_math.scad>
include <../mate/motion.scad>

function _cg_cusp_scale(modul,tooth_number) = modul*tooth_number*_cg_circle_pi/16;
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
