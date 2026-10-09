include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_cosine_quintic_pair
 * @brief Build a Cosine Quintic gear pair.
 * Alternative 2 separates the driver and mate and uses the contrasting gear controls described above.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png Cosine Quintic pair 1
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.png Cosine Quintic pair 2
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param depth {number} Quintic depth.
 * @param harmonic {integer} Cosine harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param samples {integer} Samples.
 * @param phase {number} Pair phase.
 * @param together_built {boolean} Mesh pair.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param tooth_phase {number} Tooth phase.
 * @param driver_color {string} Driver colour.
 * @param mate_color {string} Mate colour.
 */
module curve_gear_cosine_quintic_pair(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"cosine_quintic_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_cosine_quintic_shape(modul,tooth_number,depth,harmonic,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
