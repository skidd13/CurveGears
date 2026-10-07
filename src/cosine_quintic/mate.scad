include <gear.scad>
include <../common/mate/motion.scad>
include <../common/mate/placement.scad>

function _cg_cosine_quintic_motion_radii(scale,depth,harmonic,n=360) = [for(i=[0:n-1]) scale*_cg_cosine_quintic_unit_radius(360*(i+.5)/n,depth,harmonic)];
function _cg_cosine_quintic_driver_radii(scale,depth,harmonic,n=360) = [for(i=[0:n-1]) scale*_cg_cosine_quintic_unit_radius(360*i/n,depth,harmonic)];
function _cg_cosine_quintic_centre_distance(scale,depth,harmonic,n=360) = _cg_solve_mate_distance(_cg_cosine_quintic_motion_radii(scale,depth,harmonic,n),scale*(1+depth)+.01,3*scale);
function _cg_cosine_quintic_motion_table(scale,depth,harmonic,D,n=360) = _cg_motion_table_from_mid_radii(_cg_cosine_quintic_motion_radii(scale,depth,harmonic,n),D);
function _cg_cosine_quintic_mate_points(scale,depth,harmonic,D,n=360) = _cg_mate_points_from_radius_samples(_cg_cosine_quintic_driver_radii(scale,depth,harmonic,n),_cg_cosine_quintic_motion_radii(scale,depth,harmonic,n),D);

/***
 * @function curve_gear_cosine_quintic_mate
 * @brief Build a Cosine Quintic mating gear.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_mate.png Cosine Quintic mate preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param depth {number} Quintic depth.
 * @param harmonic {integer} Cosine harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 */
module curve_gear_cosine_quintic_mate(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    _cg_assert_samples(samples,"cosine_quintic_gear_mate: samples must be an integer >= 120");
    scale=_cg_cosine_quintic_scale(modul,tooth_number,samples,depth,harmonic);
    D=_cg_cosine_quintic_centre_distance(scale,depth,harmonic,samples);
    mate=_cg_cosine_quintic_mate_points(scale,depth,harmonic,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/** @function curve_gear_cosine_quintic_centre_distance
 * @brief Return the Cosine Quintic centre distance.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param depth {number} Quintic depth.
 * @param harmonic {integer} Cosine harmonic.
 * @param samples {integer} Samples.
 */
function curve_gear_cosine_quintic_centre_distance(modul,tooth_number,depth=.19,harmonic=2,samples=720) = let(scale=_cg_cosine_quintic_scale(modul,tooth_number,samples,depth,harmonic)) _cg_cosine_quintic_centre_distance(scale,depth,harmonic,samples);

/** @function curve_gear_cosine_quintic_mate_rotation
 * @brief Return the Cosine Quintic mate rotation.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param depth {number} Quintic depth.
 * @param harmonic {integer} Cosine harmonic.
 * @param samples {integer} Samples.
 * @param phase {number} Driver phase.
 */
function curve_gear_cosine_quintic_mate_rotation(modul,tooth_number,depth=.19,harmonic=2,samples=720,phase=0) = let(scale=_cg_cosine_quintic_scale(modul,tooth_number,samples,depth,harmonic),D=_cg_cosine_quintic_centre_distance(scale,depth,harmonic,samples),motion=_cg_cosine_quintic_motion_table(scale,depth,harmonic,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
