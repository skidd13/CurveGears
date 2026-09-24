include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/**
 * @function _cg_pascal_motion_radii
 * @brief Evaluate Pascal radii at integration midpoints.
 * @param scale {number > 0} Base radial scale.
 * @param eccentricity {number} Pascal curve eccentricity.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array of number} Sampled radii in angular order.
 */
function _cg_pascal_motion_radii(scale,eccentricity,n=360) = [for(i=[0:n-1]) _cg_pascal_radius(scale,eccentricity,360*(i+.5)/n)];
/** @function _cg_pascal_driver_radii
 * @brief Evaluate Pascal radii at direct mate-construction angles.
 */
function _cg_pascal_driver_radii(scale,eccentricity,n=360) = [for(i=[0:n-1]) _cg_pascal_radius(scale,eccentricity,360*i/n)];
/**
 * @function _cg_pascal_motion_table
 * @brief Build the shared Pascal phase-motion table.
 * @param scale {number > 0} Base radial scale.
 * @param eccentricity {number} Pascal curve eccentricity.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array} Monotonic driver-to-mate phase-motion table.
 */
function _cg_pascal_motion_table(scale,eccentricity,D,n=360) = _cg_motion_table_from_mid_radii(_cg_pascal_motion_radii(scale,eccentricity,n),D);
/**
 * @function _cg_pascal_mate_points_from_driver
 * @brief Build Pascal mate pitch points by advancing driver angle directly.
 * @param scale {number > 0} Base radial scale.
 * @param eccentricity {number} Pascal curve eccentricity.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param motion {array} Shared driver-to-mate phase-motion table.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_pascal_mate_points_from_driver(scale,eccentricity,D,n=360) =
    _cg_mate_points_from_radius_samples(_cg_pascal_driver_radii(scale,eccentricity,n),_cg_pascal_motion_radii(scale,eccentricity,n),D);
/**
 * @function _cg_pascal_mate_points
 * @brief Build Pascal mate pitch points and their shared motion table.
 * @param scale {number > 0} Base radial scale.
 * @param eccentricity {number} Pascal curve eccentricity.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_pascal_mate_points(scale,eccentricity,D,n=360) = _cg_pascal_mate_points_from_driver(scale,eccentricity,D,n);

/***
 * @function curve_gear_pascal_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone Pascal mate boundary at the origin.
 * @image ../images/functions/pascal/curve_gear_pascal_mate.png Pascal mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.25} Pascal curve eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 */
module curve_gear_pascal_mate(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360) {
    assert(eccentricity >= 0 && eccentricity < 1,"pascal_gear_mate: eccentricity must satisfy 0 <= e < 1");
    assert(samples >= 120 && floor(samples)==samples,"pascal_gear_mate: samples must be an integer >= 120");
    scale=_cg_pascal_scale(modul,tooth_number,eccentricity,samples);
    D=_cg_solve_mate_distance(_cg_pascal_motion_radii(scale,eccentricity,samples),_cg_pascal_max_radius(scale,eccentricity)+.01,4*_cg_pascal_max_radius(scale,eccentricity));
    mate=_cg_pascal_mate_points(scale,eccentricity,D,samples);
    radial_root=_cg_pascal_requires_radial_root(eccentricity);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,radial_root,backlash,clearance);
}

/***
 * @function curve_gear_pascal_centre_distance(modul, tooth_number, eccentricity, ...)
 * @brief Return the mathematical centre distance for a Pascal pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1, default 0.25} Pascal curve eccentricity.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_pascal_centre_distance(modul,tooth_number,eccentricity=0.25,samples=360) = let(scale=_cg_pascal_scale(modul,tooth_number,eccentricity,samples),mx=_cg_pascal_max_radius(scale,eccentricity)) _cg_solve_mate_distance(_cg_pascal_motion_radii(scale,eccentricity,samples),mx+.01,4*mx);

/***
 * @function curve_gear_pascal_mate_rotation(modul, tooth_number, eccentricity, ...)
 * @brief Return the conjugate Pascal mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1, default 0.25} Pascal curve eccentricity.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_pascal_mate_rotation(modul,tooth_number,eccentricity=0.25,samples=360,phase=0) = let(scale=_cg_pascal_scale(modul,tooth_number,eccentricity,samples),mx=_cg_pascal_max_radius(scale,eccentricity),D=_cg_solve_mate_distance(_cg_pascal_motion_radii(scale,eccentricity,samples),mx+.01,4*mx),motion=_cg_pascal_motion_table(scale,eccentricity,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
