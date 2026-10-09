include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_fourier_pair
 * @brief Build a meshed or separated Fourier pair using one shared motion table.
 * @param modul {number > 0, default .8} Tooth module in mm.
 * @param tooth_number {integer >= 3, default 34} Number of teeth.
 * @param width {number > 0, default 4} Extrusion width in mm.
 * @param bore {number >= 0, default 4.8} Centre bore diameter in mm.
 * @param coefficients {array of [harmonic, amplitude, phase], default [[2,.10,0]]} Same polar coefficients as the driver.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Place the pair meshed when true.
 * @param backlash {undef or >= 0, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0, default undef} Additional radial root clearance in mm.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * @example c
 * curve_gear_fourier_pair(1, 24, 4, 8, [[2, .10, 0], [3, .04, 30]]);
 */
module curve_gear_fourier_pair(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,samples=360,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(_cg_fourier_coefficients_valid(coefficients),"fourier_gear_pair: invalid coefficients");
    _cg_assert_samples(samples,"fourier_gear_pair: samples must be an integer >= 120");
    _cg_polar_pair(_cg_fourier_shape(modul,tooth_number,coefficients,samples),modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
