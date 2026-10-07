include <gear.scad>
include <../common/mate/motion.scad>
include <../common/mate/placement.scad>

function _cg_logistic_dwell_motion_radii(scale,gain,depth,n=360) = [for(i=[0:n-1]) scale*_cg_logistic_dwell_unit_radius(360*(i+.5)/n,gain,depth)];
function _cg_logistic_dwell_driver_radii(scale,gain,depth,n=360) = [for(i=[0:n-1]) scale*_cg_logistic_dwell_unit_radius(360*i/n,gain,depth)];
function _cg_logistic_dwell_centre_distance(scale,gain,depth,n=360) = _cg_solve_mate_distance(_cg_logistic_dwell_motion_radii(scale,gain,depth,n),scale*(1+depth/2)+.01,3*scale);
function _cg_logistic_dwell_motion_table(scale,gain,depth,D,n=360) = _cg_motion_table_from_mid_radii(_cg_logistic_dwell_motion_radii(scale,gain,depth,n),D);
function _cg_logistic_dwell_mate_points(scale,gain,depth,D,n=360) = _cg_mate_points_from_radius_samples(_cg_logistic_dwell_driver_radii(scale,gain,depth,n),_cg_logistic_dwell_motion_radii(scale,gain,depth,n),D);

/***
 * @function curve_gear_logistic_dwell_mate
 * @brief Build a Logistic Dwell mating gear.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate.png Logistic Dwell mate 1
 * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell_mate_alternative.png Logistic Dwell mate 2
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param gain {number} Logistic gain.
 * @param depth {number} Dwell depth.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 */
module curve_gear_logistic_dwell_mate(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    _cg_assert_samples(samples,"logistic_dwell_gear_mate: samples must be an integer >= 120");
    scale=_cg_logistic_dwell_scale(modul,tooth_number,samples,gain,depth);
    D=_cg_logistic_dwell_centre_distance(scale,gain,depth,samples);
    mate=_cg_logistic_dwell_mate_points(scale,gain,depth,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/** @function curve_gear_logistic_dwell_centre_distance
 * @brief Return the Logistic Dwell centre distance.
 *
 * @param modul {number} Tooth module.
 *
 * @param tooth_number {integer} Tooth count.
 *
 * @param gain {number} Logistic gain.
 *
 * @param depth {number} Dwell depth.
 *
 * @param samples {integer} Samples.
 */
function curve_gear_logistic_dwell_centre_distance(modul,tooth_number,gain=8,depth=.2,samples=720) = let(scale=_cg_logistic_dwell_scale(modul,tooth_number,samples,gain,depth)) _cg_logistic_dwell_centre_distance(scale,gain,depth,samples);

/** @function curve_gear_logistic_dwell_mate_rotation
 * @brief Return the Logistic Dwell mate rotation for a driver phase.
 *
 * @param modul {number} Tooth module.
 *
 * @param tooth_number {integer} Tooth count.
 *
 * @param gain {number} Logistic gain.
 *
 * @param depth {number} Dwell depth.
 *
 * @param samples {integer} Samples.
 *
 * @param phase {number} Driver phase.
 */
function curve_gear_logistic_dwell_mate_rotation(modul,tooth_number,gain=8,depth=.2,samples=720,phase=0) = let(scale=_cg_logistic_dwell_scale(modul,tooth_number,samples,gain,depth),D=_cg_logistic_dwell_centre_distance(scale,gain,depth,samples),motion=_cg_logistic_dwell_motion_table(scale,gain,depth,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
