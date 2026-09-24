include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/**
 * @function _cg_ellipse_motion_radii
 * @brief Evaluate ellipse radii at integration midpoints.
 * @param a {number > 0} Ellipse semi-major scale.
 * @param b {number > 0} Ellipse semi-minor scale.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array of number} Sampled radii in angular order.
 */
function _cg_ellipse_motion_radii(a,b,n=360) = [for(i=[0:n-1]) _cg_ellipse_radius(a,b,360*(i+.5)/n)];
/**
 * @function _cg_ellipse_driver_radii
 * @brief Evaluate ellipse radii at direct mate-construction angles.
 */
function _cg_ellipse_driver_radii(a,b,n=480) = [for(i=[0:n-1]) _cg_ellipse_radius(a,b,360*i/n)];
/**
 * @function _cg_ellipse_centre_distance
 * @brief Solve the ellipse conjugate centre distance.
 * @param a {number > 0} Ellipse semi-major scale.
 * @param b {number > 0} Ellipse semi-minor scale.
 * @return {number} Conjugate centre distance.
 */
function _cg_ellipse_centre_distance(a,b,n=360) = _cg_solve_mate_distance(_cg_ellipse_motion_radii(a,b,n),a+0.01,3*a);
/**
 * @function _cg_ellipse_motion_table
 * @brief Build the shared ellipse phase-motion table.
 * @param a {number > 0} Ellipse semi-major scale.
 * @param b {number > 0} Ellipse semi-minor scale.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 480} Number of midpoint samples.
 * @return {array} Monotonic driver-to-mate phase-motion table.
 */
function _cg_ellipse_motion_table(a,b,D,n=480) = _cg_motion_table_from_mid_radii(_cg_ellipse_motion_radii(a,b,n),D);
/**
 * @function _cg_ellipse_mate_points_from_driver
 * @brief Build ellipse mate pitch points by advancing driver angle directly.
 * @param a {number > 0} Ellipse semi-major scale.
 * @param b {number > 0} Ellipse semi-minor scale.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param motion {array} Shared driver-to-mate phase-motion table.
 * @param n {integer >= 1, default 480} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_ellipse_mate_points_from_driver(a,b,D,n=480) =
    _cg_mate_points_from_radius_samples(_cg_ellipse_driver_radii(a,b,n),_cg_ellipse_motion_radii(a,b,n),D);
/**
 * @function _cg_ellipse_mate_points
 * @brief Build ellipse mate pitch points and their shared motion table.
 * @param a {number > 0} Ellipse semi-major scale.
 * @param b {number > 0} Ellipse semi-minor scale.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 480} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_ellipse_mate_points(a,b,D,n=480) = _cg_ellipse_mate_points_from_driver(a,b,D,n);

/***
 * @function curve_gear_ellipse_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone elliptical mate boundary at the origin.
 * @image ../images/functions/ellipse/curve_gear_ellipse_mate.png Ellipse mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 */
module curve_gear_ellipse_mate(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480) {
    assert(eccentricity >= 0 && eccentricity < 1,"elliptical_gear_mate: eccentricity must satisfy 0 <= e < 1");
    assert(samples >= 120 && floor(samples)==samples,"elliptical_gear_mate: samples must be an integer >= 120");
    axes=_cg_ellipse_axes(modul,tooth_number,eccentricity);
    a=axes[0]; b=axes[1];
    D=_cg_ellipse_centre_distance(a,b,samples);
    mate=_cg_ellipse_mate_points(a,b,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/***
 * @function curve_gear_ellipse_centre_distance(modul, tooth_number, eccentricity, ...)
 * @brief Return the mathematical centre distance for an elliptical pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param samples {integer >= 120, default 480} Motion-table sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_ellipse_centre_distance(modul,tooth_number,eccentricity=0.62,samples=480) = let(ax=_cg_ellipse_axes(modul,tooth_number,eccentricity)) _cg_ellipse_centre_distance(ax[0],ax[1],samples);

/***
 * @function curve_gear_ellipse_mate_rotation(modul, tooth_number, eccentricity, ...)
 * @brief Return the conjugate elliptical mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param samples {integer >= 120, default 480} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_ellipse_mate_rotation(modul,tooth_number,eccentricity=0.62,samples=480,phase=0) = let(ax=_cg_ellipse_axes(modul,tooth_number,eccentricity),D=_cg_ellipse_centre_distance(ax[0],ax[1],samples),motion=_cg_ellipse_motion_table(ax[0],ax[1],D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
