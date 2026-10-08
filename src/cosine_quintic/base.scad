/**
 * @module Cosine Quintic
 * @brief Signed fifth-power cosine polar pitch curves.
 *
 * The unit law is `r(theta)=1+0.19*sgn(cos(2 theta))*abs(cos(2 theta))^5`.
 * The odd signed power preserves continuity while flattening the plateaux.
 * Reference: https://en.wikipedia.org/wiki/Power_function.
 */
include <../common/curve_gears_math.scad>

/**
 * @function _cg_cosine_quintic_parameters_valid(depth,harmonic)
 * @brief Check the shared curve-parameter contract for every family entry point.
 * @param depth {number between 0 and 0.5} Curve parameter.
 * @param harmonic {integer >= 1} Curve parameter.
 * @return {boolean} True when all curve parameters are supported.
 */
function _cg_cosine_quintic_parameters_valid(depth,harmonic) = depth>0 && depth<.5 && harmonic>=1 && floor(harmonic)==harmonic;

function _cg_cosine_quintic_unit_radius(theta,depth=.19,harmonic=2) =
    assert(_cg_cosine_quintic_parameters_valid(depth,harmonic),"cosine_quintic: invalid curve parameters")
    let(c=cos(harmonic*theta)) 1+depth*(c>=0 ? pow(c,5) : -pow(-c,5));

function _cg_cosine_quintic_unit_points(samples=720,depth=.19,harmonic=2) =
    [for(i=[0:samples-1]) let(theta=360*i/samples,r=_cg_cosine_quintic_unit_radius(theta,depth,harmonic)) [r*cos(theta),r*sin(theta)]];

function _cg_cosine_quintic_scale(modul,tooth_number,samples=720,depth=.19,harmonic=2,unit_points=undef) =
    _cg_pitch_scale_from_points(modul,tooth_number,is_undef(unit_points) ? _cg_cosine_quintic_unit_points(samples,depth,harmonic) : unit_points,_cg_pi);

function _cg_cosine_quintic_points(modul,tooth_number,samples=720,depth=.19,harmonic=2,unit_points=undef) =
    let(u=is_undef(unit_points) ? _cg_cosine_quintic_unit_points(samples,depth,harmonic) : unit_points,
        scale=_cg_cosine_quintic_scale(modul,tooth_number,samples,depth,harmonic,u))
    _cg_scale_points(scale,u);
