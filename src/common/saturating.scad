/***
 * @module Saturating common
 * @brief Private stable saturating harmonic law for named polar curve adapters.
 *
 * Family adapters own parameter validation, correction harmonics and scaling.
 */
include <common_math.scad>

/**
 * @function _cg_saturating_unit_radius
 * @brief Evaluate a bounded tanh modulation around unit mean radius.
 * @param theta {angle} Physical polar angle in degrees.
 * @param harmonic {integer > 0} Number of modulation periods per turn.
 * @param transition {number > 0} Saturation transition gain.
 * @param amplitude {number} Signed modulation amplitude.
 * @return {number} Unit radius using the existing non-overflowing tanh helper.
 */
function _cg_saturating_unit_radius(theta,harmonic,transition,amplitude) =
    1+amplitude*_cg_tanh(transition*sin(harmonic*theta));
