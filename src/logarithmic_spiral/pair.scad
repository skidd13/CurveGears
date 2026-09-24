/***
 * @function curve_gear_logarithmic_spiral_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated logarithmic-spiral pair.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_pair.png Logarithmic spiral pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param sectors {integer >= 1, default 1} Number of spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Radius growth per sector.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param assembly_clearance {number >= 0, default 0} Explicit reference separation beyond the radial extents in mm.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param samples {integer >= 120, default 360} Spiral sampling density.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * Pair geometry uses the single-gear parameters documented in gear.scad.
  * @see curve_gear_logarithmic_spiral
 * @example c
 * curve_gear_logarithmic_spiral_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module _cg_logarithmic_spiral_pair_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,samples=360,together_built=true,assembly_clearance=0,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
/***
 * @function _cg_logarithmic_spiral_pair_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,samples=360,together_built=true,assembly_clearance=0,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")
 * @brief Internal logarithmic spiral pair construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param sectors {integer, default 1} Internal construction parameter.
 * @param growth_rate {number, default 1.17} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param samples {integer, default 360} Pitch-curve or motion-table sampling density.
 * @param together_built {boolean, default true} Use meshed placement when true, display placement otherwise.
 * @param assembly_clearance {number, default 0} Internal construction parameter.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param driver_color {string, default "SteelBlue"} Driver display colour.
 * @param mate_color {string, default "Gold"} Mate display colour.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    rmin=_cg_logspiral_rmin(modul,tooth_number,sectors,growth_rate);
    rmax=_cg_logspiral_rmax(modul,tooth_number,sectors,growth_rate);
    reference_distance=rmin+rmax+assembly_clearance;
    assert(samples >= 120 && floor(samples)==samples,"logarithmic_spiral_pair: samples must be an integer >= 120");
    assert(assembly_clearance >= 0,"logarithmic_spiral_pair: assembly_clearance must be non-negative");

    // Drawing
    _cg_static_pair_assembly(reference_distance,together_built,0,180,rmax,rmax,modul) {
        color(driver_color) curve_gear_logarithmic_spiral(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_logarithmic_spiral_mate(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}

module curve_gear_logarithmic_spiral_pair(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,samples=360,together_built=true,assembly_clearance=0,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_logarithmic_spiral_pair_build(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,samples,together_built,assembly_clearance,backlash,clearance,tooth_phase,driver_color,mate_color);
}
