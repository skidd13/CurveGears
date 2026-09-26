/***
 * @module Pair assembly
 * @brief Place already-defined driver and mate modules as a pair.
 *
 * This file deliberately contains no family equations. Meshed placement uses
 * the mathematical centre distance exactly; separated display placement uses
 * an explicit visual gap.
 */

/***
 * @function _cg_pair_display_separation(driver_extent, mate_extent, modul)
 * @brief Return the explicit non-meshed display separation for two extents.
 * @param driver_extent {number > 0} Driver display extent from its origin.
 * @param mate_extent {number > 0} Mate display extent from its origin.
 * @param modul {number > 0} Tooth module used for the display gap.
 * @return {number} Display separation in mm.
 */
function _cg_pair_display_separation(driver_extent,mate_extent,modul) =
    driver_extent + mate_extent + 4*modul;

/**
 * @function _cg_pair_point_extent
 * @brief Return the maximum radial extent of a sampled pitch curve.
 * @param points {array of points} Sampled pitch curve.
 * @return {number} Maximum distance from the curve origin.
 */
function _cg_pair_point_extent(points) = max([for(p=points) _cg_vlen(p)]);

/**
 * @module _cg_assert_pair_gap_failures
 * @brief Raise the canonical opposing-tooth gap diagnostic when needed.
 * @param failures {array} Pair gap failure records.
 */
module _cg_assert_pair_gap_failures(failures) {
    assert(len(failures)==0,
        str("stage=collision severity=error code=MATE_TOOTH_GAP_INSUFFICIENT pair=",len(failures)>0 ? failures[0][1] : -1,"/",len(failures)>0 ? failures[0][2] : -1," hit=",len(failures)>0 ? failures[0][3] : []," distance=",len(failures)>0 ? failures[0][4] : -1));
}

/**
 * @module _cg_pair_assembly
 * @brief Prepare once, validate once, and render both pair gears from shared states.
 * @param centre_distance {number > 0} Mathematical centre distance.
 * @param motion {motion table} Family motion table.
 * @param phase {angle, default 0} Driver motion phase.
 * @param together_built {boolean, default true} Use meshed placement when true.
 * @param driver_extent {number > 0} Driver display extent.
 * @param mate_extent {number > 0} Mate display extent.
 * @param modul {number > 0} Tooth module.
 * @param driver_points {array of points} Driver pitch curve.
 * @param mate_points {array of points} Mate pitch curve.
 * @param tooth_number {integer >= 3} Shared tooth count.
 * @param width {number > 0} Extrusion width.
 * @param bore {number >= 0} Centre bore diameter.
 * @param pressure_angle {angle, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param driver_radial_root {boolean, default false} Driver radial-root construction.
 * @param mate_radial_root {boolean, default false} Mate radial-root construction.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate colour.
 */
module _cg_pair_assembly(centre_distance,motion,phase,together_built,driver_extent,mate_extent,modul,driver_points,mate_points,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,driver_radial_root,mate_radial_root,driver_color,mate_color) {
    mate_rotation=_cg_mate_rotation_for_phase(motion,phase);
    display_distance=_cg_pair_display_separation(driver_extent,mate_extent,modul);
    _cg_assert_gear_inputs(driver_points,modul,tooth_number,bore,pressure_angle,clearance,mate_points);
    driver_state=_cg_tooth_geometry_state(driver_points,modul,tooth_number,pressure_angle,tooth_phase,driver_radial_root,backlash,clearance,false,true);
    mate_state=_cg_tooth_geometry_state(mate_points,modul,tooth_number,pressure_angle,tooth_phase,mate_radial_root,backlash,clearance,false,true);
    gap_failures=together_built ? _cg_pair_gap_failures_from_states(driver_state,mate_state,modul,centre_distance,phase,mate_rotation,clearance) : [];
    _cg_assert_pair_gap_failures(gap_failures);
    if(together_built) {
        translate([-centre_distance/2,0,0]) rotate([0,0,phase]) color(driver_color) _cg_gear_from_state(driver_state,modul,tooth_number,width,bore,pressure_angle,tooth_phase,driver_radial_root,backlash,clearance,false);
        translate([ centre_distance/2,0,0]) rotate([0,0,mate_rotation]) color(mate_color) _cg_gear_from_state(mate_state,modul,tooth_number,width,bore,pressure_angle,tooth_phase,mate_radial_root,backlash,clearance,false);
    } else {
        rotate([0,0,phase]) color(driver_color) _cg_gear_from_state(driver_state,modul,tooth_number,width,bore,pressure_angle,tooth_phase,driver_radial_root,backlash,clearance,false);
        translate([display_distance,0,0]) rotate([0,0,180]) color(mate_color) _cg_gear_from_state(mate_state,modul,tooth_number,width,bore,pressure_angle,tooth_phase,mate_radial_root,backlash,clearance,false);
    }
}

/***
 * @function _cg_static_pair_assembly(reference_distance, together_built, driver_rotation, mate_rotation, ...)
 * @brief Places a statically classified reference pair without implying conjugate motion.
 * @param reference_distance {number > 0} Explicit reference centre separation.
 * @param together_built {boolean, default true} Use reference placement when true, display placement otherwise.
 * @param driver_rotation {angle, default 0} Driver display rotation.
 * @param mate_rotation {angle, default 180} Fixed mate display rotation.
 * @param driver_extent {number > 0} Display extent of the driver from its origin.
 * @param mate_extent {number > 0} Display extent of the mate from its origin.
 * @param modul {number > 0} Tooth module used for the explicit display gap.
 * @return {geometry} The two child modules in reference or separated placement.
 */
module _cg_static_pair_assembly(reference_distance,together_built=true,driver_rotation=0,mate_rotation=180,driver_extent=1,mate_extent=1,modul=1) {
    display_distance=_cg_pair_display_separation(driver_extent,mate_extent,modul);
    if(together_built) {
        translate([-reference_distance/2,0,0]) rotate([0,0,driver_rotation]) children(0);
        translate([ reference_distance/2,0,0]) rotate([0,0,mate_rotation]) children(1);
    } else {
        rotate([0,0,driver_rotation]) children(0);
        translate([display_distance,0,0]) rotate([0,0,mate_rotation]) children(1);
    }
}
