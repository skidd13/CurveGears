include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/** @function _cg_cassini_motion_radii
 * @brief Evaluate Cassini radii at integration midpoints.
 */
function _cg_cassini_motion_radii(scale,focus_ratio,n=720) = [for(i=[0:n-1]) _cg_cassini_radius(scale,focus_ratio,360*(i+.5)/n)];
/** @function _cg_cassini_driver_radii
 * @brief Evaluate Cassini radii at direct mate-construction angles.
 */
function _cg_cassini_driver_radii(scale,focus_ratio,n=720) = [for(i=[0:n-1]) _cg_cassini_radius(scale,focus_ratio,360*i/n)];
/** @function _cg_cassini_centre_distance
 * @brief Solve the Cassini conjugate centre distance.
 */
function _cg_cassini_centre_distance(scale,focus_ratio,n=720) =
    let(mx=_cg_cassini_max_radius(scale,focus_ratio,max(1440,n)))
    _cg_solve_mate_distance(_cg_cassini_motion_radii(scale,focus_ratio,n),mx+.01,4*mx);
/** @function _cg_cassini_motion_table
 * @brief Build the shared Cassini phase-motion table.
 */
function _cg_cassini_motion_table(scale,focus_ratio,D,n=720) =
    _cg_motion_table_from_mid_radii(_cg_cassini_motion_radii(scale,focus_ratio,n),D);
/** @function _cg_cassini_mate_points_from_driver
 * @brief Build Cassini mate pitch points by advancing driver angle directly.
 */
function _cg_cassini_mate_points_from_driver(scale,focus_ratio,D,n=720) =
    _cg_mate_points_from_radius_samples(_cg_cassini_driver_radii(scale,focus_ratio,n),_cg_cassini_motion_radii(scale,focus_ratio,n),D);
/** @function _cg_cassini_mate_points
 * @brief Build Cassini mate pitch points.
 */
function _cg_cassini_mate_points(scale,focus_ratio,D,n=720) = _cg_cassini_mate_points_from_driver(scale,focus_ratio,D,n);

/**
 * @function curve_gear_cassini_mate
 * @brief Build the standalone conjugate mate for a Cassini driver.
 * @image ../images/functions/cassini/curve_gear_cassini_mate.png Cassini mate preview
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
    scale=_cg_cassini_scale(modul,tooth_number,focus_ratio,samples);
    D=_cg_cassini_centre_distance(scale,focus_ratio,samples);
    mate=_cg_cassini_mate_points(scale,focus_ratio,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
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
    let(scale=_cg_cassini_scale(modul,tooth_number,focus_ratio,samples)) _cg_cassini_centre_distance(scale,focus_ratio,samples);

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
    let(scale=_cg_cassini_scale(modul,tooth_number,focus_ratio,samples),D=_cg_cassini_centre_distance(scale,focus_ratio,samples),motion=_cg_cassini_motion_table(scale,focus_ratio,D,samples))
    _cg_mate_rotation_for_phase(motion,phase);
