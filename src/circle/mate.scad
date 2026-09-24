include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/***
 * @function curve_gear_circle_centre_distance
 * @brief Return the reference centre distance for a circular pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_circle_centre_distance(modul,tooth_number) = modul*tooth_number;

/***
 * @function curve_gear_circle_mate
 * @brief Build the circular reference mate boundary at the origin.
 * @image ../images/functions/circle/curve_gear_circle_mate.png Circle mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Circular pitch-curve sampling density.
 */
module curve_gear_circle_mate(modul,tooth_number,width,bore,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480) {
    curve_gear_circle(modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}
