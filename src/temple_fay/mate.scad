include <gear.scad>

/*** @function curve_gear_temple_fay_mate
 * @brief Build a separated Temple Fay mate presentation.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_mate.png Temple Fay mate 1
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_mate_alternative.png Temple Fay mate 2
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
module curve_gear_temple_fay_mate(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) { curve_gear_temple_fay(modul,tooth_number,width,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,180); }

/** @function curve_gear_temple_fay_centre_distance
 * @brief Return the Temple Fay reference centre distance.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param samples {integer} Samples.
 */
function curve_gear_temple_fay_centre_distance(modul,tooth_number,wing=.24,fold=.07,samples=720) = let(scale=_cg_temple_fay_scale(modul,tooth_number,samples,wing,fold)) 2*scale;

/** @function curve_gear_temple_fay_mate_rotation
 * @brief Return the Temple Fay reference mate rotation.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param samples {integer} Samples.
 * @param phase {number} Driver phase.
 */
function curve_gear_temple_fay_mate_rotation(modul,tooth_number,wing=.24,fold=.07,samples=720,phase=0) = 180-phase;
