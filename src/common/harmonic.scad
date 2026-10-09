/***
 * @module Harmonic common
 * @brief Private finite-harmonic radius law shared by named curve adapters.
 *
 * Coefficients are [harmonic, amplitude, phase in degrees]. Family adapters
 * own admissibility, pitch scaling and sampling; this evaluator does not
 * inherit the public Fourier family's coefficient-domain restrictions.
 */
include <common_math.scad>

/**
 * @function _cg_harmonic_unit_radius
 * @brief Evaluate a finite cosine series around unit mean radius.
 * @param coefficients {array} Harmonic, amplitude and phase rows.
 * @param theta {angle} Physical polar angle in degrees.
 * @return {number} Unit radius before family-specific scaling.
 */
function _cg_harmonic_unit_radius(coefficients,theta) =
    1+_cg_sum([for(c=coefficients) c[1]*cos(c[0]*theta+c[2])]);
