include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>
include <../common/mate/motion.scad>

/***
 * @function curve_gear_lobed_mate
 * @brief Build the standalone lobed mate boundary at the origin.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param lobes {integer >= 2, default 4} Number of radial lobes.
 * @param lobe_depth {0 < depth < 0.5, default 0.13} Normalised lobe amplitude.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 */
module curve_gear_lobed_mate(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    assert(lobes >= 2 && floor(lobes)==lobes,"lobed_gear_mate: lobes must be an integer >= 2");
    assert(lobe_depth > 0 && lobe_depth < 0.5,"lobed_gear_mate: lobe_depth must satisfy 0 < lobe_depth < 0.5");
    _cg_assert_samples(samples,"lobed_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_lobed_shape(modul,tooth_number,lobes,lobe_depth,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/***
 * @function curve_gear_lobed_centre_distance
 * @brief Return the mathematical centre distance for a lobed pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param lobes {integer >= 1, default 4} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1, default 0.13} Radial modulation depth.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_lobed_centre_distance(modul,tooth_number,lobes=4,lobe_depth=0.13,samples=720) = _cg_polar_mate_distance(_cg_lobed_shape(modul,tooth_number,lobes,lobe_depth,samples),samples);

/***
 * @function curve_gear_lobed_mate_rotation
 * @brief Return the conjugate lobed mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param lobes {integer >= 1, default 4} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1, default 0.13} Radial modulation depth.
 * @param samples {integer >= 120, default 720} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_lobed_mate_rotation(modul,tooth_number,lobes=4,lobe_depth=0.13,samples=720,phase=0) = _cg_polar_mate_rotation(_cg_lobed_shape(modul,tooth_number,lobes,lobe_depth,samples),samples,phase);
