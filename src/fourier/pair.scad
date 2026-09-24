include <mate.scad>
include <../pair/assembly.scad>

/***
 * @function curve_gear_fourier_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated Fourier pair using one shared motion table.
 * @image ../images/functions/fourier/curve_gear_fourier_pair.png Fourier pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same polar coefficients as the driver.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Place the pair meshed when true.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * @example c
 * curve_gear_fourier_pair(1, 24, 4, 8, [[2, .10, 0], [3, .04, 30]]);
 */
module curve_gear_fourier_pair(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,samples=360,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(_cg_fourier_coefficients_valid(coefficients),"fourier_gear_pair: invalid coefficients");
    assert(samples>=120 && floor(samples)==samples,"fourier_gear_pair: samples must be an integer >= 120");
    base=modul*tooth_number/2;
    D=_cg_fourier_centre_distance(base,coefficients,samples);
    motion=_cg_fourier_motion_table(base,coefficients,D,samples);
    closure_error=motion[len(motion)-1][1]-360;
    assert(abs(closure_error)<.08,"fourier_gear_pair: conjugate closure error too large");
    driver=[for(i=[0:samples-1]) _cg_fourier_point(base,coefficients,360*i/samples)];
    mate=_cg_fourier_mate_points_from_driver(base,coefficients,D,samples);
    _cg_pair_assembly(D,motion,phase,together_built,max([for(p=driver) _cg_vlen(p)]),max([for(p=mate) _cg_vlen(p)]),modul) {
        color(driver_color) curve_gear_fourier(modul,tooth_number,width,bore,coefficients,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_fourier_mate(modul,tooth_number,width,bore,coefficients,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}
