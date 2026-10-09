include <mate.scad>
include <../common/pair/assembly.scad>

/*** @function curve_gear_temple_fay_pair
 * @brief Build a Temple Fay driver and dynamically solved conjugate mate, separated by default.
 *
 * @param modul {number, default .8} Tooth module.
 * @param tooth_number {integer, default 34} Tooth count.
 * @param width {number, default 4} Width.
 * @param bore {number, default 4.8} Bore.
 * @param wing {number, default .18} Wing amplitude.
 * @param fold {number, default .05} Fold harmonic.
 * @param pressure_angle {number, default 20} Pressure angle.
 * @param samples {integer, default 720} Samples.
 * @param phase {number, default 0} Pair phase.
 * @param together_built {boolean, default false} Use meshed placement when true, separated display placement otherwise.
 * @param backlash {number, default undef} Backlash.
 * @param clearance {number, default undef} Clearance.
 * @param tooth_phase {number, default 0} Tooth phase.
 * @param driver_color {string, default "SteelBlue"} Driver colour.
 * @param mate_color {string, default "Gold"} Mate colour.
 */
module curve_gear_temple_fay_pair(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,samples=720,phase=0,together_built=false,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(wing>0 && wing<.5 && fold>=0 && fold<.2,"temple_fay_gear_pair: invalid parameters");
    _cg_assert_samples(samples,"temple_fay_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_temple_fay_shape(modul,tooth_number,wing,fold,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
