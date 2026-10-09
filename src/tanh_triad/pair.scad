include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_tanh_triad_pair
 * @brief Build a Tanh Triad gear pair.
 *
 * @param modul {number, default .8} Tooth module.
 *
 * @param tooth_number {integer, default 34} Tooth count.
 *
 * @param width {number, default 4} Width.
 *
 * @param bore {number, default 4.8} Bore.
 *
 * @param transition {number, default 1.8} Transition.
 *
 * @param crest {number, default .13} Crest.
 *
 * @param correction {number, default .03} Correction.
 *
 * @param pressure_angle {number, default 20} Pressure angle.
 *
 * @param samples {integer, default 720} Samples.
 *
 * @param phase {number, default 0} Pair phase.
 *
 * @param together_built {boolean, default true} Mesh pair.
 *
 * @param backlash {number, default undef} Backlash.
 *
 * @param clearance {number, default undef} Clearance.
 *
 * @param tooth_phase {number, default 0} Tooth phase.
 *
 * @param driver_color {string, default "SteelBlue"} Driver colour.
 *
 * @param mate_color {string, default "Gold"} Mate colour.
 */
module curve_gear_tanh_triad_pair(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"tanh_triad_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_tanh_triad_shape(modul,tooth_number,transition,crest,correction,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
