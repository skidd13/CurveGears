/***
 * @module Mate generation
 * @brief Shared mate diagnostics and extrusion wrapper for an already-sampled
 * mate boundary.
 *
 * Family mate files own the mate point mathematics. This layer only routes
 * the sampled boundary through the canonical CurveGears tooth/placement
 * builder, keeping mate construction separate from ordinary gear imports.
 * It requires curve_gears_math.scad to have been loaded first.
 */

/**
 * @function _cg_mate_pitch_diagnostics
 * @brief Return the required numerical and geometric mate diagnostics.
 * @param driver_radii {array of number} Driver radii at output angles.
 * @param mid_radii {array of number} Driver radii at integration midpoints.
 * @param D {number > 0} Solved centre distance in mm.
 * @param mate_points {array of points} Directly constructed mate pitch points.
 * @return {array} Named diagnostic records suitable for echo or test output.
 */
function _cg_mate_pitch_diagnostics(driver_radii,mid_radii,D,mate_points) =
    let(
        mate_radii=[for(r=driver_radii) D-r],
        ratios=[for(i=[0:len(driver_radii)-1]) driver_radii[i]/mate_radii[i]],
        motion=_cg_motion_values_from_mid_radii(mid_radii,D),
        intersections=_cg_polygon_intersections(mate_points),
        closure=_cg_sum(motion)-360
    )
    [
        ["centre_distance",D],
        ["closure_error",closure],
        ["minimum_driver_radius",min(driver_radii)],
        ["maximum_driver_radius",max(driver_radii)],
        ["minimum_mate_radius",min(mate_radii)],
        ["maximum_mate_radius",max(mate_radii)],
        ["minimum_transmission_ratio",min(ratios)],
        ["maximum_transmission_ratio",max(ratios)],
        ["integration_sample_count",len(mid_radii)],
        ["refinement_count",0],
        ["self_intersection_count",len(intersections)],
        ["pitch_mate_valid",abs(closure)<=_cg_tolerance && min(driver_radii)>0 && min(mate_radii)>0 && len(intersections)==0]
    ];

/***
 * @function _cg_mate_boundary_from_pitch_points(mate_points, modul, tooth_number, width, bore, ...)
 * @brief Build one mate from its canonical sampled pitch boundary.
 * @image ../images/tooth/assembly.png Mate boundary assembly preview
 * @param mate_points {array} Sampled mate pitch boundary points.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle} Involute pressure angle in degrees.
 * @param radial_root {boolean, default false} Use radial-root tooth construction.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @return {geometry} Extruded mate boundary.
 */
module _cg_mate_boundary_from_pitch_points(mate_points,modul,tooth_number,width,bore,pressure_angle,radial_root=false,backlash=undef,clearance=undef) {
    _cg_gear_from_pitch_points(mate_points,modul,tooth_number,width,bore,pressure_angle,0,radial_root,backlash,clearance,false);
}
