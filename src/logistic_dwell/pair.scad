include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_logistic_dwell_pair
 * @brief Build a Logistic Dwell gear pair.
 *
 * @param modul {number, default .8} Tooth module.
 * @param tooth_number {integer, default 34} Tooth count.
 * @param width {number, default 4} Width.
 * @param bore {number, default 4.8} Bore.
 * @param gain {number, default 8} Logistic gain.
 * @param depth {number, default .2} Dwell depth.
 * @param pressure_angle {number, default 20} Pressure angle.
 * @param samples {integer, default 720} Samples.
 * @param phase {number, default 0} Pair phase.
 * @param together_built {boolean, default true} Mesh pair.
 * @param backlash {number, default undef} Backlash.
 * @param clearance {number, default undef} Clearance.
 * @param tooth_phase {number, default 0} Tooth phase.
 * @param driver_color {string, default "SteelBlue"} Driver colour.
 * @param mate_color {string, default "Gold"} Mate colour.
 */
module curve_gear_logistic_dwell_pair(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"logistic_dwell_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_logistic_dwell_shape(modul,tooth_number,gain,depth,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
