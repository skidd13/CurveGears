include <../common/common_math.scad>

/***
 * @module Tooth Generation
 * @brief Build and validate one cached local tooth candidate.
 * This layer owns the pinned reference involute equations, local flank polylines,
 * tangent-aligned top closure, shared tolerances and validation. It is independent
 * of curve-family placement. The candidate is calculated once per gear and reused.
 * Validation follows kill-early-kill-cheap order: finite geometry, flank shape and
 * ordering, top geometry, crossings, then the expensive boundary scan.
 */

// Tooth generation is deliberately independent of curve-family placement.
// This file owns the pinned reference equations, one reusable local tooth,
// and the cheap-to-expensive validation pipeline for that candidate.

// Local circular-involute approximation, derived from the pinned reference.
/*** @function _cg_involute(r, rho)
 * @brief Evaluate one point of the local circular involute approximation.
 * @param r {number > 0} Base radius in mm.
 * @param rho {angle} Involute parameter in degrees.
 * @return {array} `[radius, angle]` polar point.
 */
function _cg_involute(r,rho) = [r/cos(rho),_cg_degrees(tan(rho)-_cg_radians(rho))];
/*** @function _cg_addendum(modul)
 * @brief Calculate the reference addendum for a module.
 * @param modul {number > 0} Tooth module in mm.
 * @return {number} Addendum in mm.
 */
function _cg_addendum(modul) = modul < 1 ? 1.1*modul : modul;
/*** @function _cg_default_clearance(modul)
 * @brief Calculate the default radial root clearance.
 * @param modul {number > 0} Tooth module in mm.
 * @return {number} Default clearance in mm.
 */
function _cg_default_clearance(modul) = modul+modul/6-_cg_addendum(modul);
/*** @function _cg_dedendum(modul, clearance)
 * @brief Calculate the tooth dedendum from module and optional clearance.
 * @param modul {number > 0} Tooth module in mm.
 * @param clearance {undef or >= 0} Optional radial root clearance in mm.
 * @return {number} Dedendum in mm.
 */
function _cg_dedendum(modul,clearance=undef) = is_undef(clearance)
    ? modul+modul/6 : _cg_addendum(modul)+clearance;
/*** @function _cg_default_backlash(modul)
 * @brief Calculate the reference backlash for a module.
 * @param modul {number > 0} Tooth module in mm.
 * @return {number} Default backlash in mm.
 */
function _cg_default_backlash(modul) = _cg_circle_pi*modul*0.025;
/*** @function _cg_tooth_angles(modul, z, pressure_angle, backlash)
 * @brief Calculate the radii and angular limits of a reference tooth.
 * @param modul {number > 0} Tooth module in mm.
 * @param z {integer >= 3} Tooth count.
 * @param pressure_angle {angle} Involute pressure angle in degrees.
 * @param backlash {undef or >= 0} Optional backlash in mm.
 * @return {array} Reference radii and angular values used by the tooth builder.
 */
function _cg_tooth_angles(modul,z,pressure_angle,backlash=undef) =
    let(d=modul*z,r=d/2,rb=d*cos(pressure_angle)/2,
        ra=((modul < 1) ? d+modul*2.2 : d+modul*2)/2,
        rho_r=acos(rb/r),phi_r=_cg_degrees(tan(rho_r)-_cg_radians(rho_r)),
        half_width=is_undef(backlash) ? 180*(1-0.05)/z : 180/z-360*backlash/(_cg_circle_pi*modul*z))
    [rb,ra,acos(rb/ra),half_width+2*phi_r,is_undef(backlash) ? -phi_r-90*(1-0.05)/z : -phi_r-half_width/2];
/*** @function _cg_tooth_polygon(modul, z, pressure_angle, backlash)
 * @brief Build the local polygon for one reference tooth.
 * @param modul {number > 0} Tooth module in mm.
 * @param z {integer >= 3} Tooth count.
 * @param pressure_angle {angle, default 20} Involute pressure angle in degrees.
 * @param backlash {undef or >= 0} Optional backlash in mm.
 * @return {array} Local tooth polygon points.
 */
function _cg_tooth_polygon(modul,z,pressure_angle=20,backlash=undef) =
    let(a=_cg_tooth_angles(modul,z,pressure_angle,backlash),step=a[2]/16)
    concat([[0,0]],
        [for(rho=[0:step:a[2]]) _cg_polar(_cg_involute(a[0],rho))],
        [_cg_polar(_cg_involute(a[0],a[2]))],
        [for(rho=[a[2]:-step:0]) _cg_polar([_cg_involute(a[0],rho)[0],a[3]-_cg_involute(a[0],rho)[1]])]);

// Compatibility oracle module. Production family gears use the calculated
// 2D candidate below; this module remains available for legacy consumers.
/***
 * @function _cg_involute_tooth(modul, tooth_number, pressure_angle, backlash)
 * @brief Render the legacy compatibility involute-tooth module.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param pressure_angle {angle, default 20} Involute pressure angle in degrees.
 * @param backlash {undef or >= 0} Optional backlash in mm.
 * @return {geometry} Bounded legacy involute tooth.
 */
module _cg_involute_tooth(modul,tooth_number,pressure_angle=20,backlash=undef) {
    assert(modul > 0 && tooth_number >= 3,"invalid module or tooth count");
    assert(pressure_angle > 0 && pressure_angle < 90,"invalid pressure angle");
    assert(is_undef(backlash) || (backlash >= 0 && backlash < _cg_circle_pi*modul/2),"backlash must be below half the circular pitch");
    a=_cg_tooth_angles(modul,tooth_number,pressure_angle,backlash);
    intersection() {
        translate([-modul*tooth_number/2,0])
            rotate(a[4]) polygon(_cg_tooth_polygon(modul,tooth_number,pressure_angle,backlash));
        translate([-1.35*modul,-2.5*modul]) square([2.6*modul,5*modul]);
    }
}

/**
 * @function _cg_eps_len
 * @brief Return the shared positional tolerance for tooth checks.
 * @return {number} Positional tolerance.
 */
function _cg_eps_len() = 1e-7;
/**
 * @function _cg_eps_angle
 * @brief Return the shared angular tolerance for tooth checks.
 * @return {number} Angular tolerance in degrees.
 */
function _cg_eps_angle() = 1e-5;
/**
 * @function _cg_eps_intersect
 * @brief Return the shared segment-intersection tolerance.
 * @return {number} Segment-intersection tolerance.
 */
function _cg_eps_intersect() = 1e-7;
/**
 * @function _cg_eps_area
 * @brief Return the minimum meaningful polygon area.
 * @return {number} Polygon-area tolerance.
 */
function _cg_eps_area() = 1e-8;

/**
 * @function _cg_signed_area
 * @brief Calculate the signed area of a closed 2D polyline.
 * @param points {array of points} Closed 2D polyline.
 * @return {number} Signed polygon area.
 */
function _cg_signed_area(points) =
    _cg_sum([for(i=[0:len(points)-1]) _cg_cross2(points[i],points[(i+1)%len(points)])])/2;

/**
 * @function _cg_point_finite
 * @brief Test whether one 2D point contains finite coordinates.
 * @param p {point} Point to test.
 * @return {boolean} True when both coordinates are finite.
 */
function _cg_point_finite(p) = p[0] == p[0] && p[1] == p[1] && abs(p[0]) < 1e100 && abs(p[1]) < 1e100;

/**
 * @function _cg_polyline_finite
 * @brief Test every point in a polyline for finite coordinates.
 * @param points {array of points} Polyline to test.
 * @return {boolean} True when every point is finite.
 */
function _cg_polyline_finite(points) = len(points) >= 1 && min([for(p=points) _cg_point_finite(p) ? 1 : 0]) == 1;

/**
 * @function _cg_segment_intersection
 * @brief Test two segments and return their intersection parameters.
 * @param a {point} First segment start.
 * @param b {point} First segment end.
 * @param c {point} Second segment start.
 * @param d {point} Second segment end.
 * @return {array} `[hit, point, t, u]` intersection result.
 */
function _cg_segment_intersection(a,b,c,d) =
    let(
        r=_cg_vsub(b,a),
        s=_cg_vsub(d,c),
        qmp=_cg_vsub(c,a),
        denominator=_cg_cross2(r,s),
        t=abs(denominator) > _cg_eps_intersect() ? _cg_cross2(qmp,s)/denominator : 0,
        u=abs(denominator) > _cg_eps_intersect() ? _cg_cross2(qmp,r)/denominator : 0,
        hit=abs(denominator) > _cg_eps_intersect()
            && t >= -_cg_eps_intersect() && t <= 1+_cg_eps_intersect()
            && u >= -_cg_eps_intersect() && u <= 1+_cg_eps_intersect()
    )
    [hit,hit ? [a[0]+t*r[0],a[1]+t*r[1]] : [0,0],t,u];

/**
 * @function _cg_bbox_segments_overlap
 * @brief Perform a cheap bounding-box overlap test for two segments.
 * @param a {point} First segment start.
 * @param b {point} First segment end.
 * @param c {point} Second segment start.
 * @param d {point} Second segment end.
 * @return {boolean} True when the segment bounding boxes overlap.
 */
function _cg_bbox_segments_overlap(a,b,c,d) =
    max(min(a[0],b[0]),min(c[0],d[0])) <= min(max(a[0],b[0]),max(c[0],d[0]))+_cg_eps_intersect()
    && max(min(a[1],b[1]),min(c[1],d[1])) <= min(max(a[1],b[1]),max(c[1],d[1]))+_cg_eps_intersect();

/**
 * @function _cg_polygon_intersections
 * @brief Find exact non-neighbouring polygon crossings after broad phase.
 * @param points {array of points} Closed polygon to inspect.
 * @return {array} Non-neighbouring segment intersection records.
 */
function _cg_polygon_intersections(points) = [
    for(i=[0:len(points)-2]) for(j=[i+1:len(points)-1])
        let(adjacent=j==i+1 || (i==0 && j==len(points)-1),
            a=points[i],b=points[(i+1)%len(points)],c=points[j],d=points[(j+1)%len(points)],
            hit=_cg_bbox_segments_overlap(a,b,c,d)
                ? _cg_segment_intersection(a,b,c,d)
                : [false,[0,0],0,0])
        if(!adjacent && hit[0]) [i,j,hit[1]]
];

/**
 * @function _cg_polygon_area
 * @brief Calculate the absolute area of a closed polyline.
 * @param points {array of points} Closed polygon.
 * @return {number} Absolute polygon area.
 */
function _cg_polygon_area(points) = abs(_cg_signed_area(points));

/**
 * @function _cg_vertical_line_hits
 * @brief Find finite flank intersections at a top x coordinate.
 * @param points {array of points} Flank polyline.
 * @param x {number} Top-line x coordinate.
 * @return {array} Segment indices and intersection points.
 */
function _cg_vertical_line_hits(points,x) = [
    for(i=[0:len(points)-2])
        let(a=points[i],b=points[i+1],minimum=min(a[0],b[0]),maximum=max(a[0],b[0]))
        if(x >= minimum-_cg_eps_intersect() && x <= maximum+_cg_eps_intersect())
            abs(b[0]-a[0]) <= _cg_eps_intersect()
                ? [i,[x,(a[1]+b[1])/2]]
                : let(t=(x-a[0])/(b[0]-a[0])) [i,[x,a[1]+t*(b[1]-a[1])]]
];

/**
 * @function _cg_top_line_crosses_flank
 * @brief Detect unintended top/flank crossings.
 * @param top_left {point} Left end of the top line.
 * @param top_right {point} Right end of the top line.
 * @param flank {array of points} Flank polyline.
 * @return {boolean} True when the top line crosses the flank internally.
 */
function _cg_top_line_crosses_flank(top_left,top_right,flank) =
    len([for(i=[0:len(flank)-2])
        let(hit=_cg_segment_intersection(top_left,top_right,flank[i],flank[i+1]))
        if(hit[0] && _cg_vlen(_cg_vsub(hit[1],top_left))>_cg_eps_intersect()
            && _cg_vlen(_cg_vsub(hit[1],top_right))>_cg_eps_intersect()) 1]) > 0;

/**
 * @function _cg_first_flank_crossing
 * @brief Detect the first left/right flank crossing before the top.
 * @param left {array of points} Left flank polyline.
 * @param right {array of points} Right flank polyline.
 * @return {array} Crossing status, segment indices and point.
 */
function _cg_first_flank_crossing(left,right) =
    let(hits=[for(i=[0:len(left)-2]) for(j=[0:len(right)-2])
        let(hit=_cg_segment_intersection(left[i],left[i+1],right[j],right[j+1]))
        if(hit[0] && !(i==0 && j==0) && _cg_vlen(hit[1]) > _cg_eps_intersect()) [i,j,hit[1]]])
    len(hits)>0 ? concat([true],hits[0]) : [false,-1,-1,[0,0]];

/*** @function _cg_has_flank_crossing(left, right)
 * @brief Determine whether the two local tooth flanks cross.
 * @param left {array} Left flank points.
 * @param right {array} Right flank points.
 * @return {boolean} True when a non-origin crossing is found.
 */
function _cg_has_flank_crossing(left,right) = _cg_first_flank_crossing(left,right)[0];

/**
 * @function _cg_flank_failure_code
 * @brief Perform cheap flank checks before crossing scans.
 * @param left {array of points} Left flank polyline.
 * @param right {array of points} Right flank polyline.
 * @param top_left {point} Left top corner.
 * @param top_right {point} Right top corner.
 * @return {string} Validation failure code or `PASS`.
 */
function _cg_flank_failure_code(left,right) =
    len(left)!=len(right) || len(left)<3 ? "FLANK_TOO_SHORT" :
    min([for(i=[1:len(left)-1]) _cg_vlen(_cg_vsub(left[i],right[i]))]) <= _cg_eps_len() ? "FLANK_TOO_SHORT" :
    min([for(i=[1:len(left)-1]) right[i][1]-left[i][1]]) <= _cg_eps_len() ? "FLANK_ORDER_INVALID" :
    max([for(i=[0:len(left)-2])
        left[i+1][0] < left[i][0]-_cg_eps_len() || right[i+1][0] < right[i][0]-_cg_eps_len() ? 1 : 0]) == 1
        ? "FLANK_REVERSAL" :
    "PASS";

/**
 * @function _cg_reference_clearance_fraction
 * @brief Convert reference clearance and backlash to a pitch fraction.
 * @param modul {number > 0} Tooth module.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param clearance {number >= 0} Radial root clearance.
 * @param backlash {number >= 0} Tangential tooth-thickness reduction.
 * @return {number} Normalised pitch fraction.
 */
function _cg_reference_clearance_fraction(modul,backlash=undef) =
    .05 + (is_undef(backlash) ? 0 : backlash/(_cg_circle_pi*modul));

/**
 * @function _cg_reference_tooth_angles
 * @brief Return centred source flank angles.
 * @param modul {number > 0} Tooth module.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param pressure_angle {number} Involute pressure angle in degrees.
 * @param backlash {number >= 0} Tangential tooth-thickness reduction.
 * @return {array} Left and right flank angles.
 */
function _cg_reference_tooth_angles(pitch_radius,modul,tooth_number,pressure_angle=20,backlash=undef) =
    let(
        rho_pitch=acos(cos(pressure_angle)),
        phi_pitch=_cg_degrees(tan(rho_pitch)-_cg_radians(rho_pitch)),
        clearance_fraction=_cg_reference_clearance_fraction(modul,backlash),
        half_pitch=90*(1-clearance_fraction)/tooth_number,
        tooth_width=2*half_pitch+2*phi_pitch
    )
    [-phi_pitch-half_pitch,phi_pitch+half_pitch,tooth_width];

/**
 * @function _cg_reference_involute_local_point
 * @brief Evaluate one reference involute point.
 * @param base_radius {number > 0} Involute base radius.
 * @param t {number >= 0} Involute parameter.
 * @return {point} Local involute point.
 */
function _cg_reference_involute_local_point(base_radius,rho,start_angle,end_angle,side) =
    let(e=[base_radius/cos(rho),_cg_degrees(tan(rho)-_cg_radians(rho))],
        angle=side==0 ? start_angle+e[1] : end_angle-e[1])
    [e[0]*cos(angle),e[0]*sin(angle)];

/**
 * @function _cg_reference_tooth_local_flanks
 * @brief Build one cached local tooth flank pair.
 * @param modul {number > 0} Tooth module.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param pressure_angle {number} Involute pressure angle in degrees.
 * @param clearance {number >= 0} Radial root clearance.
 * @param backlash {number >= 0} Tangential tooth-thickness reduction.
 * @return {array} Local left and right flank polylines.
 */
function _cg_reference_tooth_local_flanks(pitch_radius,modul,tooth_number,pressure_angle=20,backlash=undef,clearance=undef,radial_root=false) =
    let(
        base_radius=pitch_radius*cos(pressure_angle),
        tip_radius=pitch_radius+_cg_addendum(modul),
        rho_tip=acos(base_radius/tip_radius),
        angles=_cg_reference_tooth_angles(pitch_radius,modul,tooth_number,pressure_angle,backlash),
        step=rho_tip/16,
        left_involute=[for(rho=[0:step:rho_tip]) _cg_reference_involute_local_point(base_radius,rho,angles[0],angles[1],0)],
        right_involute=[for(rho=[0:step:rho_tip]) _cg_reference_involute_local_point(base_radius,rho,angles[0],angles[1],1)],
        root_depth=radial_root ? 2*_cg_dedendum(modul,clearance)+.25*modul : _cg_dedendum(modul,clearance)+.25*modul,
        root_x=min([left_involute[0][0],right_involute[0][0],pitch_radius-root_depth])
    )
    [
        // The reference Boolean cutter used a centre sentinel. In a curved
        // frame that sentinel becomes a false inward spoke, so use only the
        // bounded normal extension needed to establish body splices.
        concat(root_x < left_involute[0][0]-_cg_eps_len() ? [[root_x,left_involute[0][1]]] : [],left_involute),
        concat(root_x < right_involute[0][0]-_cg_eps_len() ? [[root_x,right_involute[0][1]]] : [],right_involute)
    ];

/*** @function _cg_candidate_record(valid, code, top_width, tip_normal_error, left, right, left_top, right_top, boundary, left_hits, right_hits)
 * @brief Package the validated local-tooth candidate state.
 * @param valid {boolean} Candidate validity flag.
 * @param code {string} Validation status code.
 * @param top_width {number} Candidate top width in mm.
 * @param tip_normal_error {number} Tip tangency error in mm.
 * @param left {array} Left flank points.
 * @param right {array} Right flank points.
 * @param left_top {array} Left top point.
 * @param right_top {array} Right top point.
 * @param boundary {array} Candidate boundary points.
 * @param left_hits {array} Left top-intersection records.
 * @param right_hits {array} Right top-intersection records.
 * @return {array} Candidate record.
 */
function _cg_candidate_record(valid,code,top_width,tip_normal_error,left,right,left_top,right_top,boundary,left_hits,right_hits) =
    [valid,code,top_width,tip_normal_error,left,right,left_top,right_top,boundary,left_hits,right_hits];

/*** @function _cg_validate_candidate_boundary(left, right, left_top, right_top, top_width, tip_normal_error, left_hits, right_hits)
 * @brief Perform the final local tooth polygon self-intersection check.
 * @param left {array} Left flank points.
 * @param right {array} Right flank points.
 * @param left_top {array} Left top point.
 * @param right_top {array} Right top point.
 * @param top_width {number} Candidate top width in mm.
 * @param tip_normal_error {number} Tip tangency error in mm.
 * @param left_hits {array} Left top-intersection records.
 * @param right_hits {array} Right top-intersection records.
 * @return {array} Validated or failed candidate record.
 */
function _cg_validate_candidate_boundary(left,right,left_top,right_top,top_width,tip_normal_error,left_hits,right_hits) =
    let(
        boundary=concat(
            [for(i=[0:len(left)-2]) left[i]],
            [left_top,right_top],
            [for(i=[len(right)-2:-1:0]) right[i]]
        ),
        boundary_crossings=_cg_polygon_intersections(boundary),
        code=len(boundary_crossings)>0 ? "TOOTH_POLYGON_SELF_INTERSECTION" : "PASS"
    )
    _cg_candidate_record(code=="PASS",code,top_width,tip_normal_error,left,right,left_top,right_top,code=="PASS" ? boundary : [],left_hits,right_hits);

// Stage 4: exact top/flank crossings and the most expensive local polygon scan.
// Keep the scan in a separate function: OpenSCAD then evaluates it only after
// the cheap top/flank crossing test has passed.
/*** @function _cg_validate_candidate_top_geometry(left, right, left_top, right_top, top_width, tip_normal_error, left_hits, right_hits)
 * @brief Check top-line crossings before the final boundary scan.
 * @param left {array} Left flank points.
 * @param right {array} Right flank points.
 * @param left_top {array} Left top point.
 * @param right_top {array} Right top point.
 * @param top_width {number} Candidate top width in mm.
 * @param tip_normal_error {number} Tip tangency error in mm.
 * @param left_hits {array} Left top-intersection records.
 * @param right_hits {array} Right top-intersection records.
 * @return {array} Validated or failed candidate record.
 */
function _cg_validate_candidate_top_geometry(left,right,left_top,right_top,top_width,tip_normal_error,left_hits,right_hits) =
    _cg_top_line_crosses_flank(left_top,right_top,left)
        || _cg_top_line_crosses_flank(left_top,right_top,right)
        ? _cg_candidate_record(false,"TOOTH_POLYGON_SELF_INTERSECTION",top_width,tip_normal_error,left,right,left_top,right_top,[],left_hits,right_hits)
        : _cg_validate_candidate_boundary(left,right,left_top,right_top,top_width,tip_normal_error,left_hits,right_hits);

// Stage 3: top-line intersections and order. Do not scan crossings until the
// cheap cardinality, width, endpoint and tangency conditions have passed.
/*** @function _cg_validate_candidate_top(left, right)
 * @brief Validate top intersections, width, endpoint order and tangency.
 * @param left {array} Left flank points.
 * @param right {array} Right flank points.
 * @return {array} Validated or failed candidate record.
 */
function _cg_validate_candidate_top(left,right) =
    let(
        left_tip=left[len(left)-1],
        right_tip=right[len(right)-1],
        top_x=(left_tip[0]+right_tip[0])/2,
        left_top=[top_x,left_tip[1]],
        right_top=[top_x,right_tip[1]],
        tip_normal_error=abs(left_tip[0]-right_tip[0]),
        left_top_hits=_cg_vertical_line_hits(left,top_x),
        right_top_hits=_cg_vertical_line_hits(right,top_x),
        top_width=right_top[1]-left_top[1],
        top_order=right_top[1]>left_top[1],
        endpoint_code=len(left_top_hits)==0 ? "TOP_LEFT_INTERSECTION_MISSING" :
            len(right_top_hits)==0 ? "TOP_RIGHT_INTERSECTION_MISSING" :
            len(left_top_hits)>1 || len(right_top_hits)>1 ? "TOP_INTERSECTION_AMBIGUOUS" :
            abs(left_tip[0]-top_x)>_cg_eps_intersect() ? "TOP_LEFT_INTERSECTION_MISSING" :
            abs(right_tip[0]-top_x)>_cg_eps_intersect() ? "TOP_RIGHT_INTERSECTION_MISSING" :
            tip_normal_error>_cg_eps_len() ? "TOP_NOT_TANGENTIAL" :
            !top_order ? "TOP_ORDER_INVALID" : "PASS"
    )
    top_width<=_cg_eps_len() ? _cg_candidate_record(false,"TOP_WIDTH_NONPOSITIVE",top_width,tip_normal_error,left,right,left_top,right_top,[],left_top_hits,right_top_hits) :
    endpoint_code!="PASS" ? _cg_candidate_record(false,endpoint_code,top_width,tip_normal_error,left,right,left_top,right_top,[],left_top_hits,right_top_hits) :
    _cg_validate_candidate_top_geometry(left,right,left_top,right_top,top_width,tip_normal_error,left_top_hits,right_top_hits);

// Stage 2: cheap flank structure before top intersections or crossings.
/*** @function _cg_validate_candidate_flanks(flanks)
 * @brief Validate finite and ordered flanks before top and boundary checks.
 * @param flanks {array} Pair of left and right flank point lists.
 * @return {array} Validated or failed candidate record.
 */
function _cg_validate_candidate_flanks(flanks) =
    let(left=flanks[0],right=flanks[1],finite=_cg_polyline_finite(left) && _cg_polyline_finite(right))
    !finite ? _cg_candidate_record(false,"FLANK_NONFINITE",0,0,left,right,[0,0],[0,0],[],[],[]) :
    let(flank_code=_cg_flank_failure_code(left,right))
    flank_code!="PASS" ? _cg_candidate_record(false,flank_code,0,0,left,right,[0,0],[0,0],[],[],[]) :
    _cg_validate_candidate_top(left,right);

/**
 * @function _cg_reference_tooth_candidate(pitch_radius, modul, tooth_number, ...)
 * @brief Return one cached, validated local candidate tooth.
 * @image ../images/tooth/construction.png Validated tooth candidate preview
 * @param pitch_radius {number > 0} Pitch radius used to scale the reference tooth.
 * @param modul {number > 0} Tooth module.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param pressure_angle {number} Involute pressure angle in degrees.
 * @param clearance {number >= 0} Radial root clearance.
 * @param backlash {number >= 0} Tangential tooth-thickness reduction.
 * @return {array} Validated local tooth candidate and status information.
 */
function _cg_reference_tooth_candidate(pitch_radius,modul,tooth_number,pressure_angle=20,backlash=undef,clearance=undef,radial_root=false) =
    _cg_validate_candidate_flanks(_cg_reference_tooth_local_flanks(pitch_radius,modul,tooth_number,pressure_angle,backlash,clearance,radial_root));
