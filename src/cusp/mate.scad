include <gear.scad>
include <envelope_mate.scad>

/***
 * @function curve_gear_cusp_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone swept-envelope mate for a cusp gear.
 * @image ../images/functions/cusp/curve_gear_cusp_mate.png Cusp gear mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by 3} Shared tooth count.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Tooth pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 720, divisible by 3, default 720} Motion and pitch-curve sampling density for the validated cusp outline.
 * @param sweep_steps {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
 * @param max_pose_step {number > 0, default 0.5} Maximum angular step of either member in degrees.
 * @param sweep_clearance {number > 0, default 0.08} Envelope cutter clearance as a module fraction.
 * @param phase {angle, default 0} Driver phase used to orient the displayed mate.
 */
module curve_gear_cusp_mate(modul,tooth_number,width,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,phase=0) {
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number && tooth_number%3==0,
        "cusp_gear_mate: tooth_number must be an integer divisible by 3");
    _cg_assert_samples(samples,"cusp_gear_mate: samples must be an integer >= 720 for the validated cusp outline",720);
    assert(samples%3==0,"cusp_gear_mate: samples must be divisible by 3");
    geometry=_cg_cusp_pair_motion_geometry(modul,tooth_number,pressure_angle,backlash,clearance,samples);
    _cg_cusp_envelope_mate_from_geometry(geometry,modul,width,bore,sweep_steps,max_pose_step,sweep_clearance,phase);
}

/***
 * @function curve_gear_cusp_centre_distance(modul, tooth_number, samples=720)
 * @brief Return the solved pitch-curve centre distance for a cusp pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by 3} Shared tooth count.
 * @param samples {integer >= 120, divisible by 3, default 720} Motion sampling density.
 * @return {number} Fixed centre distance in mm.
 */
function curve_gear_cusp_centre_distance(modul,tooth_number,samples=720) =
    _cg_cusp_pair_motion_geometry(modul,tooth_number,20,undef,undef,samples)[3];

/***
 * @function curve_gear_cusp_mate_rotation(modul, tooth_number, samples=720, phase=0)
 * @brief Return the integrated mate angle at one driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by 3} Shared tooth count.
 * @param samples {integer >= 120, divisible by 3, default 720} Motion sampling density.
 * @param phase {angle, default 0} Driver angle in degrees.
 * @return {angle} Mate display rotation in degrees.
 */
function curve_gear_cusp_mate_rotation(modul,tooth_number,samples=720,phase=0) =
    let(geometry=_cg_cusp_pair_motion_geometry(modul,tooth_number,20,undef,undef,samples),motion=geometry[4][2])
    _cg_mate_rotation_for_phase(motion,phase);
