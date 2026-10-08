/**
 * @module Logistic Dwell
 * @brief Logistic-gated second-harmonic polar pitch curves.
 *
 * The unit law is `r(theta)=1+0.2/(1+exp(-8*sin(2 theta)))-0.1`.
 * The logistic gate creates a controlled dwell and rapid-return interval.
 * Reference: https://en.wikipedia.org/wiki/Logistic_function.
 */
include <../common/curve_gears_math.scad>

/**
 * @function _cg_logistic_dwell_parameters_valid(gain,depth)
 * @brief Check the shared curve-parameter contract for every family entry point.
 * @param gain {number > 0} Curve parameter.
 * @param depth {number between 0 and 0.5} Curve parameter.
 * @return {boolean} True when all curve parameters are supported.
 */
function _cg_logistic_dwell_parameters_valid(gain,depth) = gain>0 && depth>0 && depth<.5;

function _cg_logistic_dwell_unit_radius(theta,gain=8,depth=.2) =
    assert(_cg_logistic_dwell_parameters_valid(gain,depth),"logistic_dwell: invalid curve parameters")
    1+depth/(1+exp(-gain*sin(2*theta)))-depth/2;

function _cg_logistic_dwell_unit_points(samples=720,gain=8,depth=.2) =
    [for(i=[0:samples-1]) let(theta=360*i/samples,r=_cg_logistic_dwell_unit_radius(theta,gain,depth)) [r*cos(theta),r*sin(theta)]];

function _cg_logistic_dwell_scale(modul,tooth_number,samples=720,gain=8,depth=.2,unit_points=undef) =
    _cg_pitch_scale_from_points(modul,tooth_number,is_undef(unit_points) ? _cg_logistic_dwell_unit_points(samples,gain,depth) : unit_points,_cg_pi);

function _cg_logistic_dwell_points(modul,tooth_number,samples=720,gain=8,depth=.2,unit_points=undef) =
    let(u=is_undef(unit_points) ? _cg_logistic_dwell_unit_points(samples,gain,depth) : unit_points,
        scale=_cg_logistic_dwell_scale(modul,tooth_number,samples,gain,depth,u))
    _cg_scale_points(scale,u);
