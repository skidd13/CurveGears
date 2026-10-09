/**
 * @module Logistic Dwell
 * @brief Logistic-gated second-harmonic polar pitch curves.
 *
 * The unit law is `r(theta)=1+0.2/(1+exp(-8*sin(2 theta)))-0.1`.
 * The logistic gate creates a controlled dwell and rapid-return interval.
 * Reference: https://en.wikipedia.org/wiki/Logistic_function.
 */
include <../common/curve_gears_math.scad>
include <../common/saturating.scad>

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
    _cg_saturating_unit_radius(theta,2,gain/2,depth/2);

/**
 * @function _cg_logistic_dwell_shape
 * @brief Bind the named curve once for driver, mate and numeric consumers.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param gain {number} Named curve control.
 * @param depth {number} Named curve control.
 * @param samples {integer, default 720} Curve and motion sampling count.
 * @return {array} Shared polar shape descriptor; the family owns only its mathematical controls.
 */
function _cg_logistic_dwell_shape(modul,tooth_number,gain=8,depth=.2,samples=720) =
    _cg_polar_shape(
        function(theta) _cg_logistic_dwell_unit_radius(theta,gain,depth),
        modul,tooth_number,samples,
        function(scale) [scale*(1+depth/2)+.01,3*scale]);
