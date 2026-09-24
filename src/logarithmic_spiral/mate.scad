include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/***
 * @function curve_gear_logarithmic_spiral_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone static reference mate boundary at the origin.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_mate.png Logarithmic spiral mate preview
 * A fixed 180-degree placement is applied by the static pair assembly; this
 * module does not claim dynamic conjugacy.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3 and divisible by sectors} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param sectors {integer >= 1, default 1} Number of repeated spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Spiral sampling density.
 */
module curve_gear_logarithmic_spiral_mate(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360) {
    curve_gear_logarithmic_spiral(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/***
 * @function curve_gear_logarithmic_spiral_reference_separation(modul, tooth_number, sectors, growth_rate, assembly_clearance)
 * @brief Return the explicit static reference separation for a spiral pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3 and divisible by sectors} Number of teeth.
 * @param sectors {integer >= 1, default 1} Number of repeated spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param assembly_clearance {number >= 0, default 0} Additional separation in mm.
 * @return {number} Static reference separation in mm.
 */
function curve_gear_logarithmic_spiral_reference_separation(modul,tooth_number,sectors=1,growth_rate=1.17,assembly_clearance=0) = _cg_logspiral_rmin(modul,tooth_number,sectors,growth_rate)+_cg_logspiral_rmax(modul,tooth_number,sectors,growth_rate)+assembly_clearance;
