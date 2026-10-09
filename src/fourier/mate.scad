include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/***
 * @function curve_gear_fourier_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone dynamically conjugate Fourier mate.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/fourier/curve_gear_fourier_mate.png Fourier mate 1
 * @image ../images/functions/fourier/curve_gear_fourier_mate_alternative.png Fourier mate 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same polar coefficients as the driver.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 */
module curve_gear_fourier_mate(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360) {
    assert(_cg_fourier_coefficients_valid(coefficients),"fourier_gear_mate: invalid coefficients");
    _cg_assert_samples(samples,"fourier_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_fourier_shape(modul,tooth_number,coefficients,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/***
 * @function curve_gear_fourier_centre_distance(modul, tooth_number, coefficients)
 * @brief Return the Fourier conjugate pair centre distance.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same coefficients as the driver.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_fourier_centre_distance(modul,tooth_number,coefficients=[[2,.10,0]],samples=360) =
    _cg_polar_mate_distance(_cg_fourier_shape(modul,tooth_number,coefficients,samples),samples);

/***
 * @function curve_gear_fourier_mate_rotation(modul, tooth_number, coefficients, samples, phase)
 * @brief Return Fourier mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same coefficients as the driver.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @param phase {angle, default 0} Driver phase in degrees; negative and full-turn phases remain unwrapped.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_fourier_mate_rotation(modul,tooth_number,coefficients=[[2,.10,0]],samples=360,phase=0) =
    _cg_polar_mate_rotation(_cg_fourier_shape(modul,tooth_number,coefficients,samples),samples,phase);
