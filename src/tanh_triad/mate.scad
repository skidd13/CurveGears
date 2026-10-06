include <gear.scad>
include <../common/mate/motion.scad>
include <../common/mate/placement.scad>

function _cg_tanh_triad_motion_radii(scale,transition,crest,correction,n=360) = [for(i=[0:n-1]) scale*_cg_tanh_triad_unit_radius(360*(i+.5)/n,transition,crest,correction)];
function _cg_tanh_triad_driver_radii(scale,transition,crest,correction,n=360) = [for(i=[0:n-1]) scale*_cg_tanh_triad_unit_radius(360*i/n,transition,crest,correction)];
function _cg_tanh_triad_centre_distance(scale,transition,crest,correction,n=360) = _cg_solve_mate_distance(_cg_tanh_triad_motion_radii(scale,transition,crest,correction,n),scale*(1+crest)+.01,3*scale);
function _cg_tanh_triad_motion_table(scale,transition,crest,correction,D,n=360) = _cg_motion_table_from_mid_radii(_cg_tanh_triad_motion_radii(scale,transition,crest,correction,n),D);

function _cg_tanh_triad_mate_points(scale,transition,crest,correction,D,n=360) = _cg_mate_points_from_radius_samples(_cg_tanh_triad_driver_radii(scale,transition,crest,correction,n),_cg_tanh_triad_motion_radii(scale,transition,crest,correction,n),D);

/***
 * @function curve_gear_tanh_triad_mate
 * @brief Build a Tanh Triad mating gear.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_mate.png Tanh Triad mate preview
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param transition {number} Transition.
 * @param crest {number} Crest.
 * @param correction {number} Correction.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 */
module curve_gear_tanh_triad_mate(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    _cg_assert_samples(samples,"tanh_triad_gear_mate: samples must be an integer >= 120");
    scale=_cg_tanh_triad_scale(modul,tooth_number,samples,transition,crest,correction);
    D=_cg_tanh_triad_centre_distance(scale,transition,crest,correction,samples);
    mate=_cg_tanh_triad_mate_points(scale,transition,crest,correction,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/** @function curve_gear_tanh_triad_centre_distance
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param transition {number} Transition. @param crest {number} Crest. @param correction {number} Correction. @param samples {integer} Samples. */
function curve_gear_tanh_triad_centre_distance(modul,tooth_number,transition=1.8,crest=.13,correction=.03,samples=720) = let(scale=_cg_tanh_triad_scale(modul,tooth_number,samples,transition,crest,correction)) _cg_tanh_triad_centre_distance(scale,transition,crest,correction,samples);
/** @function curve_gear_tanh_triad_mate_rotation
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param transition {number} Transition. @param crest {number} Crest. @param correction {number} Correction. @param samples {integer} Samples. @param phase {number} Driver phase. */
function curve_gear_tanh_triad_mate_rotation(modul,tooth_number,transition=1.8,crest=.13,correction=.03,samples=720,phase=0) = let(scale=_cg_tanh_triad_scale(modul,tooth_number,samples,transition,crest,correction),D=_cg_tanh_triad_centre_distance(scale,transition,crest,correction,samples),motion=_cg_tanh_triad_motion_table(scale,transition,crest,correction,D,samples)) 180-_cg_motion_y_unwrapped(motion,phase);
