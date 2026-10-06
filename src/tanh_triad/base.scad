/**
 * @module Tanh Triad
 * @brief Bounded tanh-modulated third-harmonic polar pitch curves.
 */
include <../common/curve_gears_math.scad>

function _cg_tanh_triad_unit_radius(theta,transition=1.8,crest=.13,correction=.03) =
    1+crest*_cg_tanh(transition*sin(3*theta))+correction*cos(6*theta+20);

function _cg_tanh_triad_unit_points(samples=720,transition=1.8,crest=.13,correction=.03) =
    [for(i=[0:samples-1]) let(theta=360*i/samples,r=_cg_tanh_triad_unit_radius(theta,transition,crest,correction)) [r*cos(theta),r*sin(theta)]];

function _cg_tanh_triad_scale(modul,tooth_number,samples=720,transition=1.8,crest=.13,correction=.03,unit_points=undef) =
    _cg_pitch_scale_from_points(modul,tooth_number,is_undef(unit_points) ? _cg_tanh_triad_unit_points(samples,transition,crest,correction) : unit_points,_cg_pi);

function _cg_tanh_triad_points(modul,tooth_number,samples=720,transition=1.8,crest=.13,correction=.03,unit_points=undef) =
    let(u=is_undef(unit_points) ? _cg_tanh_triad_unit_points(samples,transition,crest,correction) : unit_points,
        scale=_cg_tanh_triad_scale(modul,tooth_number,samples,transition,crest,correction,u))
    _cg_scale_points(scale,u);
