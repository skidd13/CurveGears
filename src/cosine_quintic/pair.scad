include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_cosine_quintic_pair
 * @brief Build a Cosine Quintic gear pair.
 * Alternative 2 separates the driver and mate and uses the contrasting gear controls described above.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png Cosine Quintic pair 1
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair_alternative.png Cosine Quintic pair 2
 *
 * @param modul {number, default .8} Tooth module.
 * @param tooth_number {integer, default 34} Tooth count.
 * @param width {number, default 4} Width.
 * @param bore {number, default 4.8} Bore.
 * @param depth {number, default .19} Quintic depth.
 * @param harmonic {integer, default 2} Cosine harmonic.
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
module curve_gear_cosine_quintic_pair(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"cosine_quintic_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_cosine_quintic_shape(modul,tooth_number,depth,harmonic,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
