/**
 * @module Logistic Dwell
 * @brief Logistic-gated second-harmonic polar pitch curves.
 */
include <../common/curve_gears_math.scad>

function _cg_logistic_dwell_unit_radius(theta,gain=8,depth=.2) =
    1+depth/(1+exp(-gain*sin(2*theta)))-depth/2;

function _cg_logistic_dwell_unit_points(samples=720,gain=8,depth=.2) =
    [for(i=[0:samples-1]) let(theta=360*i/samples,r=_cg_logistic_dwell_unit_radius(theta,gain,depth)) [r*cos(theta),r*sin(theta)]];

function _cg_logistic_dwell_scale(modul,tooth_number,samples=720,gain=8,depth=.2,unit_points=undef) =
    _cg_pitch_scale_from_points(modul,tooth_number,is_undef(unit_points) ? _cg_logistic_dwell_unit_points(samples,gain,depth) : unit_points,_cg_pi);

function _cg_logistic_dwell_points(modul,tooth_number,samples=720,gain=8,depth=.2,unit_points=undef) =
    let(u=is_undef(unit_points) ? _cg_logistic_dwell_unit_points(samples,gain,depth) : unit_points,
        scale=_cg_logistic_dwell_scale(modul,tooth_number,samples,gain,depth,u))
    _cg_scale_points(scale,u);
