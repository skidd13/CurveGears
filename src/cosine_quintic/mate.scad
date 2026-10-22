include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/***
 * @function curve_gear_cosine_quintic_mate
 * @brief Build a Cosine Quintic mating gear.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param depth {number, default .19} Quintic depth.
 * @param harmonic {integer, default 2} Cosine harmonic.
 * @param pressure_angle {number, default 20} Pressure angle.
 * @param tooth_phase {number, default 0} Tooth phase.
 * @param backlash {number, default undef} Backlash.
 * @param clearance {number, default undef} Clearance.
 * @param samples {integer, default 720} Samples.
 */
module curve_gear_cosine_quintic_mate(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    _cg_assert_samples(samples,"cosine_quintic_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_cosine_quintic_shape(modul,tooth_number,depth,harmonic,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/** @function curve_gear_cosine_quintic_centre_distance
 * @brief Return the Cosine Quintic centre distance.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param depth {number, default .19} Quintic depth.
 * @param harmonic {integer, default 2} Cosine harmonic.
 * @param samples {integer, default 720} Samples.
 * @return {number} Mathematical centre distance in mm.
 */
function curve_gear_cosine_quintic_centre_distance(modul,tooth_number,depth=.19,harmonic=2,samples=720) = _cg_polar_mate_distance(_cg_cosine_quintic_shape(modul,tooth_number,depth,harmonic,samples),samples);

/** @function curve_gear_cosine_quintic_mate_rotation
 * @brief Return the Cosine Quintic mate rotation.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param depth {number, default .19} Quintic depth.
 * @param harmonic {integer, default 2} Cosine harmonic.
 * @param samples {integer, default 720} Samples.
 * @param phase {number, default 0} Driver phase.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_cosine_quintic_mate_rotation(modul,tooth_number,depth=.19,harmonic=2,samples=720,phase=0) = _cg_polar_mate_rotation(_cg_cosine_quintic_shape(modul,tooth_number,depth,harmonic,samples),samples,phase);
