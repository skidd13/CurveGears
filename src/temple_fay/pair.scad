include <mate.scad>
include <../common/pair/assembly.scad>

/*** @function curve_gear_temple_fay_pair
 * @brief Build a Temple Fay driver and dynamically solved conjugate mate, separated by default.
 * Alternative 2 separates the driver and mate and uses the contrasting gear controls described above.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_pair.png Temple Fay pair 1
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_pair_alternative.png Temple Fay pair 2
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param samples {integer} Samples.
 * @param phase {number} Pair phase.
 * @param together_built {boolean, default false} Use meshed placement when true, separated display placement otherwise.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param tooth_phase {number} Tooth phase.
 * @param driver_color {string} Driver colour.
 * @param mate_color {string} Mate colour.
 */
module curve_gear_temple_fay_pair(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,samples=720,phase=0,together_built=false,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(wing>0 && wing<.5 && fold>=0 && fold<.2,"temple_fay_gear_pair: invalid parameters");
    _cg_assert_samples(samples,"temple_fay_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_temple_fay_shape(modul,tooth_number,wing,fold,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
