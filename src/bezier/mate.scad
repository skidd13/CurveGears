/***
 * Adapt an admissible closed Bézier pitch curve to the common mate solver.
 *
 * A Cartesian Bézier path is not automatically a radial pitch curve.  This
 * adapter accepts only sampled paths that start on the positive X axis, have
 * positive radius, cover one continuous polar turn without reversal, and do
 * not self-intersect.  Rejected paths report the failed common admissibility
 * condition instead of inventing mate kinematics.
 */
include <gear.scad>
include <../mate/motion.scad>
include <../mate/placement.scad>

function _cg_bezier_polar_samples(control_points,scale,n) =
    let(points=_cg_bezier_points(control_points,scale,n))
    [for(p=points)
        let(a=atan2(p[1],p[0]),angle=a<0 ? a+360 : a)
        [angle,_cg_vlen(p)]];

function _cg_bezier_polar_table(control_points,scale,n) =
    let(samples=_cg_bezier_polar_samples(control_points,scale,n))
    concat([[0,samples[0][1]]],samples,[[360,samples[0][1]]]);

function _cg_bezier_polar_monotonic(samples,i=0) =
    i>=len(samples)-1 ? true : samples[i+1][0]>samples[i][0]+_cg_eps_angle() && _cg_bezier_polar_monotonic(samples,i+1);

function _cg_bezier_mate_admissibility(control_points,scale,n) =
    let(points=_cg_bezier_points(control_points,scale,n),polar=_cg_bezier_polar_samples(control_points,scale,n))
    !_cg_bezier_controls_valid(control_points) ? "CONTROL_CONTINUITY_INVALID" :
    abs(polar[0][0])>_cg_eps_angle() ? "POLAR_START_NOT_ZERO" :
    min([for(p=points) _cg_vlen(p)])<=_cg_eps_len() ? "NON_POSITIVE_RADIUS" :
    !_cg_bezier_polar_monotonic(polar) ? "POLAR_TRAVERSAL_NOT_MONOTONIC" :
    len(_cg_polygon_intersections(points))>0 ? "PITCH_SELF_INTERSECTION" :
    "PASS";

function _cg_bezier_radius_from_polar_table(table,theta) = _cg_interp_y_for_x(table,theta);
function _cg_bezier_driver_radii_from_table(table,n) = [for(i=[0:n-1]) _cg_bezier_radius_from_polar_table(table,360*i/n)];
function _cg_bezier_mid_radii_from_table(table,n) = [for(i=[0:n-1]) _cg_bezier_radius_from_polar_table(table,360*(i+.5)/n)];

function _cg_bezier_mate_points(control_points,scale,D,n) =
    let(table=_cg_bezier_polar_table(control_points,scale,n),driver=_cg_bezier_driver_radii_from_table(table,n),mid=_cg_bezier_mid_radii_from_table(table,n))
    _cg_mate_points_from_radius_samples(driver,mid,D);

function _cg_bezier_mate_centre_distance(control_points,scale,n) =
    let(table=_cg_bezier_polar_table(control_points,scale,n),mid=_cg_bezier_mid_radii_from_table(table,n),mx=max(mid))
    _cg_solve_mate_distance(mid,mx+.01,4*mx);

/**
 * @function curve_gear_bezier_mate
 * @brief Build a conjugate mate for an admissible radial Bézier pitch curve.
 * @image ../images/functions/bezier/curve_gear_bezier_mate.png Bézier mate preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param control_points {closed array grouped as 3n+1 points} Bézier controls.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Adapter and pitch sampling density.
 */
module curve_gear_bezier_mate(modul,tooth_number,width,bore,control_points=_cg_bezier_default_control_points,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720) {
    assert(modul>0 && width>0 && bore>=0,"bezier_gear_mate: dimensions must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"bezier_gear_mate: tooth_number must be an integer >= 3");
    assert(samples>=120 && floor(samples)==samples,"bezier_gear_mate: samples must be an integer >= 120");
    scale=modul*tooth_number/2;
    admissibility=_cg_bezier_mate_admissibility(control_points,scale,samples);
    assert(admissibility=="PASS",str("bezier_gear_mate: mate-admissibility failure code=",admissibility));
    D=_cg_bezier_mate_centre_distance(control_points,scale,samples);
    mate=_cg_bezier_mate_points(control_points,scale,D,samples);
    _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance);
}

/**
 * @function curve_gear_bezier_mate_centre_distance(modul, tooth_number, ...)
 * @brief Return the conjugate centre distance for an admissible Bézier curve.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param control_points {closed array grouped as 3n+1 points} Bézier controls.
 * @param samples {integer >= 120, default 720} Adapter and pitch sampling density.
 * @return {number} Conjugate centre distance in mm.
 */
function curve_gear_bezier_mate_centre_distance(modul,tooth_number,control_points=_cg_bezier_default_control_points,samples=720) =
    let(scale=modul*tooth_number/2) _cg_bezier_mate_centre_distance(control_points,scale,samples);

/**
 * @function curve_gear_bezier_mate_rotation(modul, tooth_number, ...)
 * @brief Return the conjugate mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param control_points {closed array grouped as 3n+1 points} Bézier controls.
 * @param samples {integer >= 120, default 720} Adapter and pitch sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Conjugate mate rotation in degrees.
 */
function curve_gear_bezier_mate_rotation(modul,tooth_number,control_points=_cg_bezier_default_control_points,samples=720,phase=0) =
    let(scale=modul*tooth_number/2,table=_cg_bezier_polar_table(control_points,scale,samples),mid=_cg_bezier_mid_radii_from_table(table,samples),driver=_cg_bezier_driver_radii_from_table(table,samples),D=_cg_solve_mate_distance(mid,max(mid)+.01,4*max(mid)),motion=_cg_motion_table_from_radius_samples(driver,mid,D))
    _cg_mate_rotation_for_phase(motion,phase);
