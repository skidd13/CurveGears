include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function _cg_cusp_pair_build
 * @brief Construct the cusp driver and swept-envelope mate as a pair.
 * @param modul {number > 0, default 1.2} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps, default 36} Number of teeth.
 * @param width {number > 0, default 4} Extrusion width in millimetres.
 * @param bore {number >= 0, default 4.8} Centre bore diameter in millimetres.
 * @param pressure_angle {0 < angle < 90, default 20} Standard-flank pressure angle.
 * @param samples {integer >= 720, divisible by cusps, default 720} Pitch and motion sample count.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Mesh the pair when true.
 * @param backlash {undef or >= 0, default undef} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0, default undef} Additional radial root clearance.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * @param sweep_steps {integer >= 36, default 360} Base driver-phase intervals.
 * @param max_pose_step {number > 0, default 0.5} Maximum member pose step in degrees.
 * @param sweep_clearance {number > 0, default 0.08} Cutter clearance as a module fraction.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 */
module _cg_cusp_pair_build(modul,tooth_number,width,bore,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,driver_color="SteelBlue",mate_color="Gold",sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,cusps=3) {
    assert(cusps>=3 && floor(cusps)==cusps,"cusp_gear: cusps must be an integer >= 3");
    assert(tooth_number>=cusps && floor(tooth_number)==tooth_number && tooth_number%cusps==0,
        "cusp_gear_pair: tooth_number must be an integer divisible by cusps");
    _cg_assert_samples(samples,"cusp_gear_pair: samples must be an integer >= 720 for the validated swept mate",720);
    assert(samples%cusps==0,"cusp_gear_pair: samples must be divisible by cusps");
    geometry=_cg_cusp_pair_motion_geometry(modul,tooth_number,pressure_angle,backlash,clearance,samples,cusps);
    driver_state=geometry[0];
    centre_distance=geometry[3];
    motion=geometry[4][2];
    closure_error=_cg_motion_closure_error(motion);
    assert(abs(closure_error)<.08,"cusp_gear_pair: envelope motion closure error too large");
    driver_outline=_cg_cusp_envelope_driver_outline(driver_state);
    mate_outer_radius=_cg_cusp_envelope_mate_outer_radius(geometry,modul);
    display_distance=_cg_pair_display_separation(_cg_pair_point_extent(driver_outline),mate_outer_radius,modul);
    if(together_built) {
        translate([-centre_distance/2,0,0]) rotate([0,0,phase]) color(driver_color)
            _cg_gear_from_state(driver_state,modul,tooth_number,width,bore,pressure_angle,-90,true,backlash,clearance,false);
        translate([centre_distance/2,0,0]) color(mate_color)
            _cg_cusp_envelope_mate_from_geometry(geometry,modul,width,bore,sweep_steps,max_pose_step,sweep_clearance,phase);
    } else {
        rotate([0,0,phase]) color(driver_color)
            _cg_gear_from_state(driver_state,modul,tooth_number,width,bore,pressure_angle,-90,true,backlash,clearance,false);
        translate([display_distance,0,0]) color(mate_color)
            _cg_cusp_envelope_mate_from_geometry(geometry,modul,width,bore,sweep_steps,max_pose_step,sweep_clearance,phase);
    }
}

/***
 * @function curve_gear_cusp_pair
 * @brief Build a meshed or separated hypocycloid cusp gear pair with a swept-envelope mate.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Shared tooth count.
 * @param width {number > 0} Gear extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Tooth pressure angle.
 * @param samples {integer >= 720, divisible by cusps, default 720} Pitch and motion sampling density for the validated swept mate.
 * @param phase {angle, default 0} Driver motion phase.
 * @param together_built {boolean, default true} Place gears at the solved pitch distance when true.
 * @param backlash {undef or >= 0, default undef} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0, default undef} Additional radial root clearance.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate colour.
 * @param sweep_steps {integer >= 36, default 360} Base driver-phase intervals for envelope construction.
 * @param max_pose_step {number > 0, default 0.5} Maximum angular step of either member in degrees.
 * @param sweep_clearance {number > 0, default 0.08} Envelope cutter clearance as a module fraction.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 */
module curve_gear_cusp_pair(modul,tooth_number,width,bore,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,driver_color="SteelBlue",mate_color="Gold",sweep_steps=360,max_pose_step=.5,sweep_clearance=.08,cusps=3) {
    _cg_cusp_pair_build(modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,driver_color,mate_color,sweep_steps,max_pose_step,sweep_clearance,cusps);
}
