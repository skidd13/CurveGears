include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/**
 * @function curve_gear_cassini_mate
 * @brief Build the standalone conjugate mate for a Cassini driver.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param focus_ratio {0 <= number < 1, default 0.78} Cassini focal ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 */
module curve_gear_cassini_mate(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    assert(_cg_cassini_focus_ratio_valid(focus_ratio),"cassini_gear_mate: focus_ratio must satisfy 0 <= focus_ratio < 1");
    _cg_assert_samples(samples,"cassini_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_cassini_shape(modul,tooth_number,focus_ratio,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/**
 * @function curve_gear_cassini_centre_distance
 * @brief Return the mathematical centre distance for a Cassini pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param focus_ratio {0 <= number < 1, default 0.78} Cassini focal ratio.
 * @param samples {integer >= 120, default 720} Motion sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_cassini_centre_distance(modul,tooth_number,focus_ratio=.78,samples=720) =
    _cg_polar_mate_distance(_cg_cassini_shape(modul,tooth_number,focus_ratio,samples),samples);

/**
 * @function curve_gear_cassini_mate_rotation
 * @brief Return the conjugate Cassini mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param focus_ratio {0 <= number < 1, default 0.78} Cassini focal ratio.
 * @param samples {integer >= 120, default 720} Motion sampling density.
 * @param phase {angle, default 0} Driver motion phase.
 * @return {angle} Mate display rotation.
 */
function curve_gear_cassini_mate_rotation(modul,tooth_number,focus_ratio=.78,samples=720,phase=0) =
    _cg_polar_mate_rotation(_cg_cassini_shape(modul,tooth_number,focus_ratio,samples),samples,phase);
