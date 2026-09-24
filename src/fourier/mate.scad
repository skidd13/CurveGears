include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

/**
 * @function _cg_fourier_motion_radii
 * @brief Evaluate Fourier radii at integration midpoints.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array of number} Sampled radii in angular order.
 */
function _cg_fourier_motion_radii(base,coefficients,n=360) = [for(i=[0:n-1]) _cg_fourier_radius(base,coefficients,360*(i+.5)/n)];
/** @function _cg_fourier_driver_radii
 * @brief Evaluate Fourier radii at direct mate-construction angles.
 */
function _cg_fourier_driver_radii(base,coefficients,n=360) = [for(i=[0:n-1]) _cg_fourier_radius(base,coefficients,360*i/n)];
/**
 * @function _cg_fourier_max_radius
 * @brief Estimate the maximum Fourier radius for the centre-distance bracket.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param n {integer >= 1, default 720} Number of samples.
 * @return {number} Maximum sampled polar radius.
 */
function _cg_fourier_max_radius(base,coefficients,n=720) = max(_cg_fourier_motion_radii(base,coefficients,n));
/**
 * @function _cg_fourier_centre_distance
 * @brief Solve the Fourier conjugate centre distance.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @return {number} Conjugate centre distance.
 */
function _cg_fourier_centre_distance(base,coefficients,n=360) = let(mx=_cg_fourier_max_radius(base,coefficients,max(720,n))) _cg_solve_mate_distance(_cg_fourier_motion_radii(base,coefficients,n),mx+.01,4*mx);
/**
 * @function _cg_fourier_motion_table
 * @brief Build the shared Fourier phase-motion table.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of midpoint samples.
 * @return {array} Monotonic driver-to-mate phase-motion table.
 */
function _cg_fourier_motion_table(base,coefficients,D,n=360) = _cg_motion_table_from_mid_radii(_cg_fourier_motion_radii(base,coefficients,n),D);
/**
 * @function _cg_fourier_mate_points_from_driver
 * @brief Build Fourier mate pitch points by advancing driver angle directly.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param motion {array} Shared driver-to-mate phase-motion table.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_fourier_mate_points_from_driver(base,coefficients,D,n=360) = _cg_mate_points_from_radius_samples(_cg_fourier_driver_radii(base,coefficients,n),_cg_fourier_motion_radii(base,coefficients,n),D);
/**
 * @function _cg_fourier_mate_points
 * @brief Build Fourier mate pitch points and their shared motion table.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param D {number > 0} Driver-to-mate centre distance.
 * @param n {integer >= 1, default 360} Number of output points.
 * @return {array of points} Cartesian mate pitch points.
 */
function _cg_fourier_mate_points(base,coefficients,D,n=360) = _cg_fourier_mate_points_from_driver(base,coefficients,D,n);

/***
 * @function curve_gear_fourier_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone dynamically conjugate Fourier mate.
 * @image ../images/functions/fourier/curve_gear_fourier_mate.png Fourier mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same polar coefficients as the driver.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 */
module curve_gear_fourier_mate(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360) {
    assert(_cg_fourier_coefficients_valid(coefficients),"fourier_gear_mate: invalid coefficients");
    assert(samples>=120 && floor(samples)==samples,"fourier_gear_mate: samples must be an integer >= 120");
    base=modul*tooth_number/2;
    D=_cg_fourier_centre_distance(base,coefficients,samples);
    mate=_cg_fourier_mate_points(base,coefficients,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,false,backlash,clearance);
}

/***
 * @function curve_gear_fourier_centre_distance(modul, tooth_number, coefficients)
 * @brief Return the Fourier conjugate pair centre distance.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same coefficients as the driver.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_fourier_centre_distance(modul,tooth_number,coefficients=[[2,.10,0]],samples=360) = _cg_fourier_centre_distance(modul*tooth_number/2,coefficients,samples);
/***
 * @function curve_gear_fourier_mate_rotation(modul, tooth_number, coefficients, samples, phase)
 * @brief Return Fourier mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param coefficients {array of [harmonic, amplitude, phase]} Same coefficients as the driver.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @param phase {angle, default 0} Driver phase in degrees; negative and full-turn phases remain unwrapped.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_fourier_mate_rotation(modul,tooth_number,coefficients=[[2,.10,0]],samples=360,phase=0) = let(base=modul*tooth_number/2,D=_cg_fourier_centre_distance(base,coefficients,samples),motion=_cg_fourier_motion_table(base,coefficients,D,samples)) _cg_mate_rotation_for_phase(motion,phase);
