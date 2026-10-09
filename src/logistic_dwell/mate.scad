include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/***
 * @function curve_gear_logistic_dwell_mate
 * @brief Build a Logistic Dwell mating gear.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png Logistic Dwell mate 1
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.png Logistic Dwell mate 2
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param gain {number} Logistic gain.
 * @param depth {number} Dwell depth.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 */
module curve_gear_logistic_dwell_mate(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    _cg_assert_samples(samples,"logistic_dwell_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_logistic_dwell_shape(modul,tooth_number,gain,depth,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/** @function curve_gear_logistic_dwell_centre_distance
 * @brief Return the Logistic Dwell centre distance.
 *
 * @param modul {number} Tooth module.
 *
 * @param tooth_number {integer} Tooth count.
 *
 * @param gain {number} Logistic gain.
 *
 * @param depth {number} Dwell depth.
 *
 * @param samples {integer} Samples.
 */
function curve_gear_logistic_dwell_centre_distance(modul,tooth_number,gain=8,depth=.2,samples=720) = _cg_polar_mate_distance(_cg_logistic_dwell_shape(modul,tooth_number,gain,depth,samples),samples);

/** @function curve_gear_logistic_dwell_mate_rotation
 * @brief Return the Logistic Dwell mate rotation for a driver phase.
 *
 * @param modul {number} Tooth module.
 *
 * @param tooth_number {integer} Tooth count.
 *
 * @param gain {number} Logistic gain.
 *
 * @param depth {number} Dwell depth.
 *
 * @param samples {integer} Samples.
 *
 * @param phase {number} Driver phase.
 */
function curve_gear_logistic_dwell_mate_rotation(modul,tooth_number,gain=8,depth=.2,samples=720,phase=0) = _cg_polar_mate_rotation(_cg_logistic_dwell_shape(modul,tooth_number,gain,depth,samples),samples,phase);
