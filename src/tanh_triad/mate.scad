include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/***
 * @function curve_gear_tanh_triad_mate
 * @brief Build a Tanh Triad mating gear.
 *
 * @param modul {number} Tooth module.
 *
 * @param tooth_number {integer} Tooth count.
 *
 * @param width {number} Width.
 *
 * @param bore {number} Bore.
 *
 * @param transition {number, default 1.8} Transition.
 *
 * @param crest {number, default .13} Crest.
 *
 * @param correction {number, default .03} Correction.
 *
 * @param pressure_angle {number, default 20} Pressure angle.
 *
 * @param tooth_phase {number, default 0} Tooth phase.
 *
 * @param backlash {number, default undef} Backlash.
 *
 * @param clearance {number, default undef} Clearance.
 *
 * @param samples {integer, default 720} Samples.
 */
module curve_gear_tanh_triad_mate(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    _cg_assert_samples(samples,"tanh_triad_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_tanh_triad_shape(modul,tooth_number,transition,crest,correction,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/***
 * @function curve_gear_tanh_triad_centre_distance
 * @brief Return the solved centre distance for a Tanh Triad pair.
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param transition {number, default 1.8} Transition.
 * @param crest {number, default .13} Crest.
 * @param correction {number, default .03} Correction.
 * @param samples {integer, default 720} Samples.
 * @return {number} Fixed centre distance in millimetres.
 */
function curve_gear_tanh_triad_centre_distance(modul,tooth_number,transition=1.8,crest=.13,correction=.03,samples=720) = _cg_polar_mate_distance(_cg_tanh_triad_shape(modul,tooth_number,transition,crest,correction,samples),samples);
/***
 * @function curve_gear_tanh_triad_mate_rotation
 * @brief Return the mate rotation at a requested Tanh Triad driver phase.
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param transition {number, default 1.8} Transition.
 * @param crest {number, default .13} Crest.
 * @param correction {number, default .03} Correction.
 * @param samples {integer, default 720} Samples.
 * @param phase {number, default 0} Driver phase.
 * @return {angle} Mate display rotation in degrees.
 */
function curve_gear_tanh_triad_mate_rotation(modul,tooth_number,transition=1.8,crest=.13,correction=.03,samples=720,phase=0) = _cg_polar_mate_rotation(_cg_tanh_triad_shape(modul,tooth_number,transition,crest,correction,samples),samples,phase);
