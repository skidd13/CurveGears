include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_tanh_triad_pair
 * @brief Build a Tanh Triad gear pair.
 * Alternative 2 separates the driver and mate and uses the contrasting gear controls described above.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_pair.png Tanh Triad pair 1
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_pair_alternative.png Tanh Triad pair 2
 *
 * @param modul {number} Tooth module.
 *
 * @param tooth_number {integer} Tooth count.
 *
 * @param width {number} Width.
 *
 * @param bore {number} Bore.
 *
 * @param transition {number} Transition.
 *
 * @param crest {number} Crest.
 *
 * @param correction {number} Correction.
 *
 * @param pressure_angle {number} Pressure angle.
 *
 * @param samples {integer} Samples.
 *
 * @param phase {number} Pair phase.
 *
 * @param together_built {boolean} Mesh pair.
 *
 * @param backlash {number} Backlash.
 *
 * @param clearance {number} Clearance.
 *
 * @param tooth_phase {number} Tooth phase.
 *
 * @param driver_color {string} Driver colour.
 *
 * @param mate_color {string} Mate colour.
 */
module curve_gear_tanh_triad_pair(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"tanh_triad_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_tanh_triad_shape(modul,tooth_number,transition,crest,correction,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
