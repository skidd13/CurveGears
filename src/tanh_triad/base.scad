/**
 * @module Tanh Triad
 * @brief Bounded tanh-modulated third-harmonic polar pitch curves.
 *
 * The unit law is `r(theta)=1+0.13*tanh(1.8*sin(3 theta))+0.03*cos(6 theta+20 degrees)`;
 * the shared arc-length pitch scaler supplies the requested mean module.
 * Reference: https://en.wikipedia.org/wiki/Hyperbolic_function.
 */
include <../common/curve_gears_math.scad>
include <../common/saturating.scad>

/**
 * @function _cg_tanh_triad_parameters_valid(transition,crest,correction)
 * @brief Check the shared curve-parameter contract for every family entry point.
 * @param transition {number > 0} Curve parameter.
 * @param crest {number between 0 and 0.5} Curve parameter.
 * @param correction {number >= 0 and < 0.2} Curve parameter.
 * @return {boolean} True when all curve parameters are supported.
 */
function _cg_tanh_triad_parameters_valid(transition,crest,correction) = transition>0 && crest>0 && crest<.5 && correction>=0 && correction<.2;

function _cg_tanh_triad_unit_radius(theta,transition=1.8,crest=.13,correction=.03) =
    assert(_cg_tanh_triad_parameters_valid(transition,crest,correction),"tanh_triad: invalid curve parameters")
    _cg_saturating_unit_radius(theta,3,transition,crest)+correction*cos(6*theta+20);

/**
 * @function _cg_tanh_triad_shape
 * @brief Bind the named curve once for driver, mate and numeric consumers.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param transition {number} Named curve control.
 * @param crest {number} Named curve control.
 * @param correction {number} Named curve control.
 * @param samples {integer, default 720} Curve and motion sampling count.
 * @return {array} Shared polar shape descriptor; the family owns only its mathematical controls.
 */
function _cg_tanh_triad_shape(modul,tooth_number,transition=1.8,crest=.13,correction=.03,samples=720) =
    _cg_polar_shape(
        function(theta) _cg_tanh_triad_unit_radius(theta,transition,crest,correction),
        modul,tooth_number,samples,
        function(scale) [function(mid) let(bound=scale*(1+crest)+.01) bound>max(mid) ? bound : max(mid)+.01,3*scale]);
