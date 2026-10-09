include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/*** @function curve_gear_temple_fay_mate
 * @brief Build the dynamically solved Temple Fay conjugate mate.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 */
module curve_gear_temple_fay_mate(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    assert(wing>0 && wing<.5 && fold>=0 && fold<.2,"temple_fay_gear_mate: invalid parameters");
    _cg_assert_samples(samples,"temple_fay_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_temple_fay_shape(modul,tooth_number,wing,fold,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/** @function curve_gear_temple_fay_centre_distance
 * @brief Solve the Temple Fay conjugate centre distance from rolling closure.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param samples {integer} Samples.
 */
function curve_gear_temple_fay_centre_distance(modul,tooth_number,wing=.18,fold=.05,samples=720) = _cg_polar_mate_distance(_cg_temple_fay_shape(modul,tooth_number,wing,fold,samples),samples);

/** @function curve_gear_temple_fay_mate_rotation
 * @brief Return the integrated Temple Fay conjugate mate rotation.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param samples {integer} Samples.
 * @param phase {number} Driver phase.
 */
function curve_gear_temple_fay_mate_rotation(modul,tooth_number,wing=.18,fold=.05,samples=720,phase=0) = _cg_polar_mate_rotation(_cg_temple_fay_shape(modul,tooth_number,wing,fold,samples),samples,phase);
