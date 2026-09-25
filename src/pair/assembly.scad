/***
 * @module Pair assembly
 * @brief Place already-defined driver and mate modules as a pair.
 *
 * This file deliberately contains no family equations and no tooth
 * construction. The caller supplies two children: driver first, mate
 * second. Meshed placement uses the mathematical centre distance exactly;
 * separated display placement uses an explicit visual gap.
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

/***
 * @function _cg_pair_assembly(centre_distance, motion, phase, together_built, ...)
 * @brief Applies driver phase, conjugate mate rotation and pair translation to two child modules.
 * @param centre_distance {number > 0} Mathematical centre distance used by the meshed pair.
 * @param motion {motion table} Family motion table used to derive mate rotation.
 * @param phase {angle, default 0} Driver motion phase.
 * @param together_built {boolean, default true} Use meshed placement when true, display placement otherwise.
 * @param driver_extent {number > 0} Display extent of the driver from its origin.
 * @param mate_extent {number > 0} Display extent of the mate from its origin.
 * @param modul {number > 0} Tooth module used for the explicit display gap.
 * @param driver_points {array of points, optional} Driver pitch curve for common state construction.
 * @param mate_points {array of points, optional} Mate pitch curve for common state construction.
 * @param tooth_number {integer >= 3, optional} Shared tooth count.
 * @return {geometry} The two child modules in meshed or separated placement.
 */
module _cg_pair_assembly(centre_distance,motion,phase=0,together_built=true,driver_extent=1,mate_extent=1,modul=1,driver_points=undef,mate_points=undef,tooth_number=undef,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef) {
    mate_rotation=_cg_mate_rotation_for_phase(motion,phase);
    display_distance=_cg_pair_display_separation(driver_extent,mate_extent,modul);
    gap_failures=together_built && !is_undef(driver_points) && !is_undef(mate_points)
        ? _cg_pair_gap_failures(driver_points,mate_points,modul,tooth_number,pressure_angle,centre_distance,phase,mate_rotation,tooth_phase,backlash,clearance)
        : [];
    assert(len(gap_failures)==0,
        str("stage=collision severity=error code=MATE_TOOTH_GAP_INSUFFICIENT pair=",len(gap_failures)>0 ? gap_failures[0][1] : -1,"/",len(gap_failures)>0 ? gap_failures[0][2] : -1," hit=",len(gap_failures)>0 ? gap_failures[0][3] : []," distance=",len(gap_failures)>0 ? gap_failures[0][4] : -1));
    if(together_built) {
        translate([-centre_distance/2,0,0]) rotate([0,0,phase]) children(0);
        translate([ centre_distance/2,0,0]) rotate([0,0,mate_rotation]) children(1);
    } else {
        rotate([0,0,phase]) children(0);
        translate([display_distance,0,0]) rotate([0,0,180]) children(1);
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
