include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/**
 * @function _cg_lobed_motion_radii
 * @brief Evaluate lobed radii at integration midpoints.
 * @param scale {number > 0} Base radial scale.
 * @param lobes {integer >= 2} Number of radial lobes.
 * @param lobe_depth {number} Normalised lobe amplitude.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array of number} Sampled radii in angular order.
 */
function _cg_lobed_motion_radii(scale,lobes,lobe_depth,n=360) = [for(i=[0:n-1]) _cg_lobed_radius(scale,lobes,lobe_depth,360*(i+.5)/n)];
/** @function _cg_lobed_driver_radii
 * @brief Evaluate lobed radii at direct mate-construction angles.
 */
function _cg_lobed_driver_radii(scale,lobes,lobe_depth,n=360) = [for(i=[0:n-1]) _cg_lobed_radius(scale,lobes,lobe_depth,360*i/n)];
/**
 * @function _cg_lobed_centre_distance
 * @brief Solve the lobed conjugate centre distance.
 * @param scale {number > 0} Base radial scale.
 * @param lobes {integer >= 2} Number of radial lobes.
 * @param lobe_depth {number} Normalised lobe amplitude.
 * @return {number} Conjugate centre distance.
 */
function _cg_lobed_centre_distance(scale,lobes,lobe_depth,n=360) = _cg_solve_mate_distance(_cg_lobed_motion_radii(scale,lobes,lobe_depth,n),scale*(1+lobe_depth)+0.01,3*scale);
/**
 * @function _cg_lobed_motion_table
 * @brief Build the shared lobed phase-motion table.
 * @param scale {number > 0} Base radial scale.
 * @param lobes {integer >= 2} Number of radial lobes.
 * @param lobe_depth {number} Normalised lobe amplitude.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array} Monotonic driver-to-mate phase-motion table.
 */
function _cg_lobed_motion_table(scale,lobes,lobe_depth,D,n=360) = _cg_motion_table_from_mid_radii(_cg_lobed_motion_radii(scale,lobes,lobe_depth,n),D);
/**
 * @function _cg_lobed_mate_points_from_driver
 * @brief Build lobed mate pitch points by advancing driver angle directly.
 * @param scale {number > 0} Base radial scale.
 * @param lobes {integer >= 2} Number of radial lobes.
 * @param lobe_depth {number} Normalised lobe amplitude.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param motion {array} Shared driver-to-mate phase-motion table.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_lobed_mate_points_from_driver(scale,lobes,lobe_depth,D,n=360) =
    _cg_mate_points_from_radius_samples(_cg_lobed_driver_radii(scale,lobes,lobe_depth,n),_cg_lobed_motion_radii(scale,lobes,lobe_depth,n),D);
/**
 * @function _cg_lobed_mate_points
 * @brief Build lobed mate pitch points and their shared motion table.
 * @param scale {number > 0} Base radial scale.
 * @param lobes {integer >= 2} Number of radial lobes.
 * @param lobe_depth {number} Normalised lobe amplitude.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_lobed_mate_points(scale,lobes,lobe_depth,D,n=360) = _cg_lobed_mate_points_from_driver(scale,lobes,lobe_depth,D,n);

/***
 * @function curve_gear_lobed_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone lobed mate boundary at the origin.
 * @image ../images/functions/lobed/curve_gear_lobed_mate.png Lobed mate preview
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
    scale=_cg_lobed_scale(modul,tooth_number,lobes,lobe_depth,samples);
    D=_cg_lobed_centre_distance(scale,lobes,lobe_depth,samples);
    mate=_cg_lobed_mate_points(scale,lobes,lobe_depth,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/***
 * @function curve_gear_lobed_centre_distance(modul, tooth_number, lobes, lobe_depth, ...)
 * @brief Return the mathematical centre distance for a lobed pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param lobes {integer >= 1, default 4} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1, default 0.13} Radial modulation depth.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_lobed_centre_distance(modul,tooth_number,lobes=4,lobe_depth=0.13,samples=720) = let(scale=_cg_lobed_scale(modul,tooth_number,lobes,lobe_depth,samples)) _cg_lobed_centre_distance(scale,lobes,lobe_depth,samples);

/***
 * @function curve_gear_lobed_mate_rotation(modul, tooth_number, lobes, lobe_depth, ...)
 * @brief Return the conjugate lobed mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param lobes {integer >= 1, default 4} Number of radial lobes.
 * @param lobe_depth {0 <= d < 1, default 0.13} Radial modulation depth.
 * @param samples {integer >= 120, default 720} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_lobed_mate_rotation(modul,tooth_number,lobes=4,lobe_depth=0.13,samples=720,phase=0) = let(scale=_cg_lobed_scale(modul,tooth_number,lobes,lobe_depth,samples),D=_cg_lobed_centre_distance(scale,lobes,lobe_depth,samples),motion=_cg_lobed_motion_table(scale,lobes,lobe_depth,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
