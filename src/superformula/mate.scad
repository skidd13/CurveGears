include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/**
 * @function _cg_superformula_motion_radii
 * @brief Evaluate superformula radii at integration midpoints.
 * @param scale {number > 0} Overall radial scale.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial parameter.
 * @param b {number > 0} Superformula radial parameter.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param n {integer >= 1, default 240} Number of midpoint samples.
 * @return {array of number} Sampled radii in angular order.
 */
function _cg_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n=240) = [for(i=[0:n-1]) _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,360*(i+.5)/n)];
/** @function _cg_superformula_driver_radii
 * @brief Evaluate superformula radii at direct mate-construction angles.
 */
function _cg_superformula_driver_radii(scale,symmetry,a,b,n1,n2,n3,n=240) = [for(i=[0:n-1]) _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,360*i/n)];
/**
 * @function _cg_superformula_centre_distance
 * @brief Solve the superformula conjugate centre distance.
 * @param scale {number > 0} Overall radial scale.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial parameter.
 * @param b {number > 0} Superformula radial parameter.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @return {number} Conjugate centre distance.
 */
function _cg_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,n=240) =
    let(mx=_cg_superformula_max_radius(scale,symmetry,a,b,n1,n2,n3,720))
    _cg_solve_mate_distance(_cg_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n),mx+0.01,4*mx);
/**
 * @function _cg_superformula_motion_table
 * @brief Build the shared superformula phase-motion table.
 * @param scale {number > 0} Overall radial scale.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial parameter.
 * @param b {number > 0} Superformula radial parameter.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array} Monotonic driver-to-mate phase-motion table.
 */
function _cg_superformula_motion_table(scale,symmetry,a,b,n1,n2,n3,D,n=360) = _cg_motion_table_from_mid_radii(_cg_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n),D);
/**
 * @function _cg_superformula_mate_points_from_driver
 * @brief Build superformula mate pitch points by advancing driver angle directly.
 * @param scale {number > 0} Overall radial scale.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial parameter.
 * @param b {number > 0} Superformula radial parameter.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param motion {array} Shared driver-to-mate phase-motion table.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_superformula_mate_points_from_driver(scale,symmetry,a,b,n1,n2,n3,D,n=360) =
    _cg_mate_points_from_radius_samples(
        _cg_superformula_driver_radii(scale,symmetry,a,b,n1,n2,n3,n),
        _cg_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n),D);
/**
 * @function _cg_superformula_mate_points
 * @brief Build superformula mate pitch points and their shared motion table.
 * @param scale {number > 0} Overall radial scale.
 * @param symmetry {integer >= 2} Number of repeated sectors.
 * @param a {number > 0} Superformula radial parameter.
 * @param b {number > 0} Superformula radial parameter.
 * @param n1 {number > 0} Superformula exponent.
 * @param n2 {number > 0} Superformula exponent.
 * @param n3 {number > 0} Superformula exponent.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_superformula_mate_points(scale,symmetry,a,b,n1,n2,n3,D,n=360) = _cg_superformula_mate_points_from_driver(scale,symmetry,a,b,n1,n2,n3,D,n);

/***
 * @function curve_gear_superformula_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone superformula mate boundary at the origin.
 * @image ../images/functions/superformula/curve_gear_superformula_mate.png Superformula mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 */
module curve_gear_superformula_mate(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360) {
    assert(symmetry >= 2 && floor(symmetry)==symmetry,"superformula_gear_mate: symmetry must be an integer >= 2");
    assert(a>0 && b>0 && n1>0 && n2>0 && n3>0,"superformula_gear_mate: a,b,n1,n2,n3 must be positive");
    assert(_cg_superformula_odd_valid(symmetry,a,b,n2,n3),"superformula_gear_mate: odd symmetry requires a=b and n2=n3 for 360-degree continuity");
    assert(samples >= 120 && floor(samples)==samples,"superformula_gear_mate: samples must be an integer >= 120");
    scale=_cg_superformula_scale(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples);
    D=_cg_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,samples);
    mate=_cg_superformula_mate_points(scale,symmetry,a,b,n1,n2,n3,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,false,backlash,clearance);
}

/***
 * @function curve_gear_superformula_centre_distance(modul, tooth_number, symmetry, a, b, n1, n2, n3, ...)
 * @brief Return the mathematical centre distance for a superformula pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_superformula_centre_distance(modul,tooth_number,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,samples=360) = let(scale=_cg_superformula_scale(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples)) _cg_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,samples);

/***
 * @function curve_gear_superformula_mate_rotation(modul, tooth_number, symmetry, a, b, n1, n2, n3, ...)
 * @brief Return the conjugate superformula mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_superformula_mate_rotation(modul,tooth_number,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,samples=360,phase=0) = let(scale=_cg_superformula_scale(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples),D=_cg_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,samples),motion=_cg_superformula_motion_table(scale,symmetry,a,b,n1,n2,n3,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
