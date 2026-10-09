/**
 * @module Cosine Quintic
 * @brief Signed fifth-power cosine polar pitch curves.
 *
 * The unit law is `r(theta)=1+0.19*sgn(cos(2 theta))*abs(cos(2 theta))^5`.
 * The odd signed power preserves continuity while flattening the plateaux.
 * Reference: https://en.wikipedia.org/wiki/Power_function.
 */
include <../common/curve_gears_math.scad>
include <../common/harmonic.scad>

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
    _cg_harmonic_unit_radius([[harmonic,10*depth/16,0],[3*harmonic,5*depth/16,0],[5*harmonic,depth/16,0]],theta);

/**
 * @function _cg_cosine_quintic_shape
 * @brief Bind the named curve once for driver, mate and numeric consumers.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param depth {number} Named curve control.
 * @param harmonic {number} Named curve control.
 * @param samples {integer, default 720} Curve and motion sampling count.
 * @return {array} Shared polar shape descriptor; the family owns only its mathematical controls.
 */
function _cg_cosine_quintic_shape(modul,tooth_number,depth=.19,harmonic=2,samples=720) =
    _cg_polar_shape(
        function(theta) _cg_cosine_quintic_unit_radius(theta,depth,harmonic),
        modul,tooth_number,samples,
        function(scale) [scale*(1+depth)+.01,3*scale]);
