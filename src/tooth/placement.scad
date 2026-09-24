include <generation.scad>

/***
 * @module Tooth Placement
 * @brief Transport the cached tooth around a curve and splice accepted teeth into the body.
 * This layer owns arc-length frames, winding-aware normals, accessibility, body
 * intersections, splice intervals and nearby tooth collision checks. It returns
 * placed, omitted_inaccessible or invalid states; it never silently repairs invalid geometry.
 * Cheap frame and candidate checks precede corridor and body scans. A source-point
 * broad phase limits exact collision checks to plausible tooth pairs; adjacent
 * pairs are checked as well, with only their explicitly shared boundary contact
 * permitted.
 */

// Tooth placement owns curve frames, accessibility, body intersections,
// replacement intervals and complete tooth-set collision validation. The gear
// layer remains responsible for the canonical final outline and extrusion.

/**
 * @function _cg_outward_normal
 * @brief Return the contour-winding outward normal.
 * @param points {array of points} Closed contour.
 * @param tangent {vector} Local tangent vector.
 * @return {vector} Winding-aware outward normal.
 */
function _cg_outward_normal(points,tangent) =
    _cg_signed_area(points) >= 0
        ? [tangent[1],-tangent[0]]
        : [-tangent[1],tangent[0]];

/*** @function _cg_curve_tangent(points, i)
 * @brief Estimate a centred tangent vector at a closed-curve point index.
 * @param points {array} Closed curve points.
 * @param i {integer} Point index.
 * @return {array} Unnormalised tangent vector.
 */
function _cg_curve_tangent(points,i) =
    let(n=len(points)) _cg_vsub(points[(i+1)%n],points[(i-1+n)%n]);

/*** @function _cg_polyline_arc_table(points)
 * @brief Build a cumulative arc-length table for a closed polyline.
 * @param points {array} Closed curve points.
 * @return {array} Table of `[point index, cumulative length]` rows.
 */
function _cg_polyline_arc_table(points) =
    let(
        n=len(points),
        ds=[for(k=[0:n-1]) _cg_vlen(_cg_vsub(points[(k+1)%n],points[k]))],
        cumulative=_cg_prefix_sums(ds)
    )
    [for(i=[0:n]) [i,cumulative[i]]];

/*** @function _cg_open_arc_table(points)
 * @brief Build a cumulative arc-length table for an open polyline.
 * @param points {array} Open curve points.
 * @return {array} Table of `[point index, cumulative length]` rows.
 */
function _cg_open_arc_table(points) =
    let(
        n=len(points),
        ds=[for(k=[0:n-2]) _cg_vlen(_cg_vsub(points[k+1],points[k]))],
        cumulative=_cg_prefix_sums(ds)
    )
    [for(i=[0:n-1]) [i,cumulative[i]]];

/*** @function _cg_point_for_closed_arc(points, arc, target)
 * @brief Interpolate a Cartesian point at a wrapped closed-curve arc position.
 * @param points {array} Closed curve points.
 * @param arc {array} Closed-curve arc-length table.
 * @param target {number} Target arc length in mm.
 * @return {array} Interpolated Cartesian point.
 */
function _cg_point_for_closed_arc(points,arc,target) =
    let(perimeter=arc[len(arc)-1][1],wrapped=target-perimeter*floor(target/perimeter),
        n=len(points),u=_cg_interp_x_for_y(arc,wrapped),i=floor(u),f=u-i)
    _cg_vlerp(points[i%n],points[(i+1)%n],f);

/*** @function _cg_tangent_for_closed_arc(points, arc, target)
 * @brief Interpolate a centred tangent at a wrapped closed-curve arc position.
 * @param points {array} Closed curve points.
 * @param arc {array} Closed-curve arc-length table.
 * @param target {number} Target arc length in mm.
 * @return {array} Unnormalised tangent vector.
 */
function _cg_tangent_for_closed_arc(points,arc,target) =
    let(
        perimeter=arc[len(arc)-1][1],
        wrapped=target-perimeter*floor(target/perimeter),
        n=len(points),
        u=_cg_interp_x_for_y(arc,wrapped),
        i=floor(u),
        f=u-i,
        t0=_cg_curve_tangent(points,i%n),
        t1=_cg_curve_tangent(points,(i+1)%n)
    )
    _cg_vlerp(t0,t1,f);

/**
 * @function _cg_local_frame_for_closed_arc
 * @brief Return point, tangent, outward normal and winding at an arc position.
 * @param points {array of points} Closed pitch contour.
 * @param arc {array} Cumulative arc-length table.
 * @param perimeter {number > 0} Total contour perimeter.
 * @param target {number} Target arc length.
 * @return {array} Local point, tangent, normal and winding.
 */
function _cg_local_frame_for_closed_arc(points,arc,perimeter,target) =
    let(
        wrapped=target-perimeter*floor(target/perimeter),
        point=_cg_point_for_closed_arc(points,arc,wrapped),
        tangent=_cg_vunit(_cg_tangent_for_closed_arc(points,arc,wrapped)),
        normal=_cg_outward_normal(points,tangent),
        winding=_cg_signed_area(points) >= 0 ? 1 : -1
    )
    [point,tangent,normal,winding];

/**
 * @function _cg_frame_failure_code
 * @brief Validate frame finiteness, scale, orthogonality and winding.
 * @param frame {array} Point, tangent, normal and winding frame.
 * @return {string} Validation failure code or `PASS`.
 */
function _cg_frame_failure_code(frame) =
    !_cg_point_finite(frame[0]) || !_cg_point_finite(frame[1]) || !_cg_point_finite(frame[2]) ? "FRAME_NONFINITE" :
    _cg_vlen(frame[1]) <= _cg_eps_len() || _cg_vlen(frame[2]) <= _cg_eps_len() ? "FRAME_ZERO_VECTOR" :
    abs(_cg_vlen(frame[1])-1) > _cg_eps_len() || abs(_cg_vlen(frame[2])-1) > _cg_eps_len() ? "FRAME_NOT_NORMALISED" :
    abs(frame[1][0]*frame[2][0]+frame[1][1]*frame[2][1]) > _cg_eps_angle() ? "FRAME_NOT_ORTHOGONAL" :
    _cg_cross2(frame[1],frame[2]) * frame[3] >= -_cg_eps_angle() ? "FRAME_NORMAL_REVERSED" :
    "PASS";

/*** @function _cg_frame_valid(frame)
 * @brief Check whether a local curve frame passes all frame invariants.
 * @param frame {array} Point, tangent, normal and winding frame.
 * @return {boolean} True when the frame is valid.
 */
function _cg_frame_valid(frame) = _cg_frame_failure_code(frame) == "PASS";

/**
 * @function _cg_profile_point_at_frame
 * @brief Map local normal/tangent coordinates into a gear frame.
 * @param local_point {point} Local tooth-profile point.
 * @param pitch_point {point} Pitch-contour point.
 * @param normal {vector} Outward frame normal.
 * @param tangent {vector} Frame tangent.
 * @param pitch_radius {number} Local pitch radius.
 * @return {point} Transformed Cartesian point.
 */
function _cg_profile_point_at_frame(local_point,pitch_point,normal,tangent,pitch_radius) =
    [
        pitch_point[0]+normal[0]*(local_point[0]-pitch_radius)+tangent[0]*local_point[1],
        pitch_point[1]+normal[1]*(local_point[0]-pitch_radius)+tangent[1]*local_point[1]
    ];

/**
 * @function _cg_canonical_body_point_at_arc
 * @brief Return a body point inward from the pitch contour.
 * @param points {array of points} Closed pitch contour.
 * @param arc {array} Cumulative arc-length table.
 * @param perimeter {number > 0} Total contour perimeter.
 * @param target {number} Target arc length.
 * @param dedendum {number >= 0} Radial inward offset.
 * @param radial_root {boolean, default false} Use radial rather than normal offset.
 * @return {point} Inward body point.
 */
function _cg_canonical_body_point_at_arc(points,arc,perimeter,target,dedendum,radial_root=false) =
    let(
        frame=_cg_local_frame_for_closed_arc(points,arc,perimeter,target),
        p=frame[0],normal=frame[2],radius=_cg_vlen(p),radial=_cg_vunit(p),
        root_radius=max(radius-dedendum,.02*dedendum)
    )
    radial_root
        ? [radial[0]*root_radius,radial[1]*root_radius]
        : [p[0]-dedendum*normal[0],p[1]-dedendum*normal[1]];

/**
 * @function _cg_canonical_body_polyline
 * @brief Build the closed canonical body before teeth merge.
 * @param points {array of points} Closed pitch contour.
 * @param arc {array} Cumulative arc-length table.
 * @param perimeter {number > 0} Total contour perimeter.
 * @param dedendum {number >= 0} Radial inward offset.
 * @param radial_root {boolean, default false} Use radial rather than normal offset.
 * @return {array of points} Closed canonical body polyline.
 */
function _cg_canonical_body_polyline(points,arc,perimeter,dedendum,radial_root=false) =
    [for(i=[0:len(points)-1])
        _cg_canonical_body_point_at_arc(points,arc,perimeter,arc[i][1],dedendum,radial_root)];

/*** @function _cg_arc_mean_segment_length(arc)
 * @brief Calculate the mean segment length represented by an arc table.
 * @param arc {array} Arc-length table.
 * @return {number} Mean segment length in mm.
 */
function _cg_arc_mean_segment_length(arc) = arc[len(arc)-1][1]/(len(arc)-1);

/**
 * @function _cg_arc_segment_is_discrete_return
 * @brief Detect long discrete return segments in an arc table.
 * @param arc {array} Cumulative arc-length table.
 * @param perimeter {number > 0} Total contour perimeter.
 * @param target {number} Target arc length.
 * @return {boolean} True when the target falls on a discrete return.
 */
function _cg_arc_segment_is_discrete_return(arc,perimeter,target) =
    let(
        wrapped=target-perimeter*floor(target/perimeter),
        u=_cg_interp_x_for_y(arc,wrapped),
        i=min(len(arc)-2,max(0,floor(u))),
        segment_length=arc[i+1][1]-arc[i][1]
    )
    segment_length > 4*_cg_arc_mean_segment_length(arc);

/*** @function _cg_arc_segment_index(arc, perimeter, target)
 * @brief Find the segment containing a wrapped arc target.
 * @param arc {array} Arc-length table.
 * @param perimeter {number > 0} Closed-curve perimeter in mm.
 * @param target {number} Target arc length in mm.
 * @return {integer} Containing segment index.
 */
function _cg_arc_segment_index(arc,perimeter,target) =
    let(wrapped=target-perimeter*floor(target/perimeter),u=_cg_interp_x_for_y(arc,wrapped))
    min(len(arc)-2,max(0,floor(u)));

/**
 * @function _cg_frame_continuity_failure_code
 * @brief Check neighbouring frames except at source discontinuities.
 * @param points {array of points} Closed pitch contour.
 * @param arc {array} Cumulative arc-length table.
 * @param perimeter {number > 0} Total contour perimeter.
 * @param target {number} Target arc length.
 * @param tooth_pitch {number > 0} Tooth pitch distance.
 * @return {string} Validation failure code or `PASS`.
 */
function _cg_frame_continuity_failure_code(points,arc,perimeter,target,tooth_pitch) =
    let(
        previous=_cg_local_frame_for_closed_arc(points,arc,perimeter,target-.5*tooth_pitch),
        next=_cg_local_frame_for_closed_arc(points,arc,perimeter,target+.5*tooth_pitch),
        discrete=max([for(k=[-1:1])
            _cg_arc_segment_is_discrete_return(arc,perimeter,target+k*.5*tooth_pitch) ? 1 : 0]) == 1,
        tangent_dot=previous[1][0]*next[1][0]+previous[1][1]*next[1][1],
        normal_dot=previous[2][0]*next[2][0]+previous[2][1]*next[2][1]
    )
    discrete ? "PASS" :
    tangent_dot < -_cg_eps_angle() || normal_dot < -_cg_eps_angle()
        ? "FRAME_DISCONTINUITY" : "PASS";

/*** @function _cg_point_in_polygon(point, polygon_points)
 * @brief Test point inclusion using an even-odd polygon crossing rule.
 * @param point {array} Cartesian point.
 * @param polygon_points {array} Polygon vertices.
 * @return {boolean} True when the point lies inside the polygon.
 */
function _cg_point_in_polygon(point,polygon_points) =
    len([for(i=[0:len(polygon_points)-1])
        let(a=polygon_points[i],b=polygon_points[(i+1)%len(polygon_points)])
        if((a[1]>point[1])!=(b[1]>point[1])
            && point[0] < (b[0]-a[0])*(point[1]-a[1])/(b[1]-a[1])+a[0]) 1]) % 2 == 1;

/*** @function _cg_segment_hits_polygon(a, b, polygon_points)
 * @brief Test whether a segment enters or intersects a polygon.
 * @param a {array} Segment start point.
 * @param b {array} Segment end point.
 * @param polygon_points {array} Polygon vertices.
 * @return {boolean} True when the segment hits or lies inside the polygon.
 */
function _cg_segment_hits_polygon(a,b,polygon_points) =
    _cg_point_in_polygon(a,polygon_points) || _cg_point_in_polygon(b,polygon_points)
    || len([for(i=[0:len(polygon_points)-1])
        let(hit=_cg_segment_intersection(a,b,polygon_points[i],polygon_points[(i+1)%len(polygon_points)]))
        if(hit[0]) 1]) > 0;

/**
 * @function _cg_accessibility_result
 * @brief Test the outward engagement corridor against remote body segments.
 * @param points {array of points} Closed pitch contour.
 * @param arc {array} Cumulative arc-length table.
 * @param perimeter {number > 0} Total contour perimeter.
 * @param body {array of points} Canonical body polyline.
 * @param target {number} Target arc length.
 * @param tooth_pitch {number > 0} Tooth pitch distance.
 * @param modul {number > 0} Tooth module.
 * @param candidate {array} Local tooth candidate.
 * @param radial_root {boolean, default false} Use radial root geometry.
 * @param clearance {number, default undef} Additional corridor clearance.
 * @return {array} Accessibility result and diagnostic data.
 */
function _cg_accessibility_result(points,arc,perimeter,body,target,tooth_pitch,modul,candidate,radial_root=false,clearance=undef) =
    let(
        frame=_cg_local_frame_for_closed_arc(points,arc,perimeter,target),
        dedendum=_cg_dedendum(modul,clearance),
        base=_cg_canonical_body_point_at_arc(points,arc,perimeter,target,dedendum,radial_root),
        tangent=frame[1],normal=frame[2],
        half_width=max(candidate[2]/2,.25*modul)+.25*modul,
        required_clearance=dedendum+_cg_addendum(modul)+.25*modul,
        outer=[base[0]+normal[0]*required_clearance,base[1]+normal[1]*required_clearance],
        corridor=[
            [base[0]-tangent[0]*half_width,base[1]-tangent[1]*half_width],
            [base[0]+tangent[0]*half_width,base[1]+tangent[1]*half_width],
            [outer[0]+tangent[0]*half_width,outer[1]+tangent[1]*half_width],
            [outer[0]-tangent[0]*half_width,outer[1]-tangent[1]*half_width]
        ],
        return_segments=[for(k=[0:8])
            let(return_target=target+(k/8-.5)*tooth_pitch)
            if(_cg_arc_segment_is_discrete_return(arc,perimeter,return_target))
                _cg_arc_segment_index(arc,perimeter,return_target)],
        hits=[for(i=[0:len(body)-1])
            let(
                s0=arc[i][1],s1=arc[i+1][1],mid=(s0+s1)/2,
                delta=(mid-target)-perimeter*floor((mid-target)/perimeter+.5),
                remote=abs(delta)>1.5*tooth_pitch,
                blocked=remote && _cg_segment_hits_polygon(body[i],body[(i+1)%len(body)],corridor)
            ) if(blocked) [i,body[i]]]
    )
    [
        len(return_segments)>0 || len(hits)>0,
        len(hits)>0 ? hits[0][0] : len(return_segments)>0 ? return_segments[0] : -1,
        len(hits)>0 ? hits[0][1] : len(return_segments)>0 ? body[return_segments[0]] : [0,0],
        len(hits)>0 ? 0 : required_clearance,
        required_clearance,frame,corridor
    ];

/*** @function _cg_body_arc_for_intersection(hit, arc)
 * @brief Convert a body intersection record to its arc position.
 * @param hit {array} Body intersection record.
 * @param arc {array} Body arc-length table.
 * @return {number} Intersection arc position in mm.
 */
function _cg_body_arc_for_intersection(hit,arc) =
    arc[hit[2]][1]+hit[4]*(arc[hit[2]+1][1]-arc[hit[2]][1]);

/*** @function _cg_local_body_hits(hits, arc, perimeter, target, tooth_pitch)
 * @brief Retain body intersections within the local tooth interval.
 * @param hits {array} Body intersection records.
 * @param arc {array} Body arc-length table.
 * @param perimeter {number > 0} Body perimeter in mm.
 * @param target {number} Tooth target arc position in mm.
 * @param tooth_pitch {number > 0} Arc distance between teeth in mm.
 * @return {array} Local intersection records with arc positions appended.
 */
function _cg_local_body_hits(hits,arc,perimeter,target,tooth_pitch) =
    [for(hit=hits)
        let(s=_cg_body_arc_for_intersection(hit,arc),delta=(s-target)-perimeter*floor((s-target)/perimeter+.5))
        if(abs(delta) <= .75*tooth_pitch) concat(hit,[s])];

/*** @function _cg_hit_seen_before(hits, index)
 * @brief Check whether an intersection point has already occurred.
 * @param hits {array} Intersection records.
 * @param index {integer} Record index to test.
 * @return {boolean} True when an earlier record is coincident.
 */
function _cg_hit_seen_before(hits,index) =
    index==0 ? false : len([for(j=[0:index-1]) if(_cg_vlen(_cg_vsub(hits[j][0],hits[index][0]))<=_cg_eps_intersect()) 1])>0;

/*** @function _cg_unique_hits(hits)
 * @brief Remove coincident intersection records while preserving order.
 * @param hits {array} Intersection records.
 * @return {array} Unique intersection records.
 */
function _cg_unique_hits(hits) =
    len(hits)==0 ? [] : [for(i=[0:len(hits)-1]) if(!_cg_hit_seen_before(hits,i)) hits[i]];

/*** @function _cg_arc_near_target(s, target, perimeter)
 * @brief Wrap an arc position to the turn nearest a target position.
 * @param s {number} Arc position in mm.
 * @param target {number} Target arc position in mm.
 * @param perimeter {number > 0} Closed-curve perimeter in mm.
 * @return {number} Nearest equivalent arc position in mm.
 */
function _cg_arc_near_target(s,target,perimeter) = s+perimeter*floor((target-s)/perimeter+.5);

/**
 * @function _cg_splice_interval
 * @brief Return one placed tooth's body replacement interval.
 * @param placement {array} Canonical placement record.
 * @param perimeter {number > 0} Body perimeter in mm.
 * @param tooth_pitch {number, default undef} Arc-length tooth pitch for cell clipping.
 * @return {array} Ordered body replacement interval.
 */
function _cg_splice_interval(placement,perimeter,tooth_pitch=undef) =
    let(
        a=_cg_arc_near_target(placement[8][5],placement[3],perimeter),
        b=_cg_arc_near_target(placement[9][5],placement[3],perimeter),
        raw_start=min(a,b),raw_end=max(a,b),
        cell_start=is_undef(tooth_pitch) ? raw_start : placement[3]-tooth_pitch/2,
        cell_end=is_undef(tooth_pitch) ? raw_end : placement[3]+tooth_pitch/2
    )
    [max(raw_start,cell_start),min(raw_end,cell_end),placement[2],placement[3]];

/**
 * @function _cg_splice_relation
 * @brief Classify two canonical body intervals.
 * @param first {array} First replacement interval.
 * @param second {array} Second replacement interval.
 * @return {string} Interval relation or `PASS`.
 */
function _cg_splice_relation(a,b) =
    a[1]-a[0] <= _cg_eps_len() || b[1]-b[0] <= _cg_eps_len() ? "SPLICE_INTERVAL_ZERO_LENGTH" :
    max(a[0],b[0]) >= min(a[1],b[1])-_cg_eps_intersect() ? "PASS" :
    ((a[0]<b[0] && b[0]<a[1] && a[1]<b[1]) || (b[0]<a[0] && a[0]<b[1] && b[1]<a[1]))
        ? "SPLICE_INTERVAL_INTERLEAVED" : "SPLICE_INTERVAL_OVERLAP";

/**
 * @function _cg_splice_failures
 * @brief Validate every accepted replacement interval.
 * @param intervals {array} Accepted replacement intervals.
 * @return {array} Splice validation failures.
 */
function _cg_splice_failures(placements,perimeter,tooth_pitch=undef) =
    let(placed=[for(p=placements) if(p[0]=="placed") p],intervals=[for(p=placed) _cg_splice_interval(p,perimeter,tooth_pitch)])
    len(intervals)==0 ? [] : concat(
        [for(i=[0:len(intervals)-1])
            if(intervals[i][1]-intervals[i][0] <= _cg_eps_len()) ["SPLICE_INTERVAL_ZERO_LENGTH",intervals[i],[]]],
        len(intervals)<2 ? [] : [for(i=[0:len(intervals)-2]) for(j=[i+1:len(intervals)-1])
            let(relation=_cg_splice_relation(intervals[i],intervals[j]))
            if(relation!="PASS") [relation,intervals[i],intervals[j]]],
        len(intervals)<2 ? [] : [for(i=[0:len(intervals)-2])
            if(intervals[i][0] > intervals[i+1][0]+_cg_eps_intersect()) ["SPLICE_ORDER_INVALID",intervals[i],intervals[i+1]]]
    );

/*** @function _cg_tooth_body_intersections(tooth_boundary, body)
 * @brief Find intersections between a placed tooth boundary and the body.
 * @param tooth_boundary {array} Tooth boundary points.
 * @param body {array} Body boundary points.
 * @return {array} Intersection records with segment indices and fractions.
 */
function _cg_tooth_body_intersections(tooth_boundary,body) =
    [for(ti=[0:len(tooth_boundary)-1],bi=[0:len(body)-1])
        let(hit=_cg_segment_intersection(tooth_boundary[ti],tooth_boundary[(ti+1)%len(tooth_boundary)],body[bi],body[(bi+1)%len(body)]))
        if(hit[0]) [hit[1],ti,bi,hit[2],hit[3]]];

// Cheap placement preflight. Expensive accessibility and body scans happen
// only after the local frame and cached tooth candidate have passed.
/*** @function _cg_placement_invalid(index, target, frame, candidate, code)
 * @brief Construct the canonical invalid placement record.
 * @param index {integer} Tooth index.
 * @param target {number} Target arc position in mm.
 * @param frame {array} Local placement frame.
 * @param candidate {array} Cached tooth candidate record.
 * @param code {string} Failure code.
 * @return {array} Invalid placement record.
 */
function _cg_placement_invalid(index,target,frame,candidate,code) =
    ["invalid",code,index,target,frame,candidate,[],[],undef,undef,[false,-1,[0,0],0,0,frame,[]],[]];

/***
 * @function _cg_placement_after_preflight(points, arc, perimeter, body, modul, tooth_number, tooth_index, candidate, pressure_angle, tooth_phase, radial_root, backlash, clearance, frame, tooth_pitch, target)
 * @brief Evaluate accessibility and body intersections after cheap placement checks.
 * @param points {array} Sampled pitch-curve points.
 * @param arc {array} Pitch-curve arc-length table.
 * @param perimeter {number > 0} Pitch-curve perimeter in mm.
 * @param body {array} Canonical body boundary.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param tooth_index {integer} Tooth index.
 * @param candidate {array} Cached tooth candidate record.
 * @param pressure_angle {angle} Involute pressure angle in degrees.
 * @param tooth_phase {angle} Tooth placement phase in degrees.
 * @param radial_root {boolean} Use radial-root construction.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param frame {array} Local placement frame.
 * @param tooth_pitch {number > 0} Arc distance between teeth in mm.
 * @param target {number} Target arc position in mm.
 * @return {array} Placed, omitted or invalid placement record.
 */
function _cg_placement_after_preflight(points,arc,perimeter,body,modul,tooth_number,tooth_index,candidate,pressure_angle,tooth_phase,radial_root,backlash,clearance,frame,tooth_pitch,target) =
    let(
        reference_pitch_radius=modul*tooth_number/2,
        accessibility=_cg_accessibility_result(points,arc,perimeter,body,target,tooth_pitch,modul,candidate,radial_root,clearance),
        accessible=!accessibility[0],
        boundary=accessible ? [for(p=[0:len(candidate[8])-1]) _cg_profile_point_at_frame(candidate[8][p],frame[0],frame[2],frame[1],reference_pitch_radius)] : [],
        hits=boundary==[] ? [] : _cg_unique_hits(_cg_tooth_body_intersections(boundary,body)),
        local_hits=boundary==[] ? [] : _cg_unique_hits(_cg_local_body_hits(hits,arc,perimeter,target,tooth_pitch)),
        left_edge_count=len(candidate[4])-1,
        right_edge_start=len(candidate[4]),
        left_hits=[for(hit=local_hits) if(hit[1]<left_edge_count) hit],
        right_hits=[for(hit=local_hits) if(hit[1]>=right_edge_start) hit],
        remote_hits=_cg_unique_hits([for(hit=hits)
            let(s=_cg_body_arc_for_intersection(hit,arc),delta=(s-target)-perimeter*floor((s-target)/perimeter+.5))
            if(abs(delta) > .75*tooth_pitch) hit]),
        first_hit=len(left_hits)>0 ? left_hits[0] : undef,
        last_hit=len(right_hits)>0 ? right_hits[0] : undef,
        hit_separation=is_undef(first_hit) || is_undef(last_hit) ? 0 : _cg_vlen(_cg_vsub(first_hit[0],last_hit[0])),
        hit_order_ok=!is_undef(first_hit) && !is_undef(last_hit) && last_hit[1] > first_hit[1],
        body_order_ok=!is_undef(first_hit) && !is_undef(last_hit)
            && _cg_arc_near_target(last_hit[5],target,perimeter) > _cg_arc_near_target(first_hit[5],target,perimeter)+_cg_eps_intersect(),
        state=!accessible || len(remote_hits)>0 ? "omitted_inaccessible" :
            len(left_hits)==0 || len(right_hits)==0 ? "invalid" :
            len(left_hits)>1 || len(right_hits)>1 || len(local_hits)>2 ? "invalid" :
            !hit_order_ok || !body_order_ok ? "invalid" :
            hit_separation<=_cg_eps_len() ? "invalid" : "placed",
        code=!accessible || len(remote_hits)>0 ? "PLACEMENT_INACCESSIBLE" :
            len(left_hits)==0 || len(right_hits)==0 ? "BODY_INTERSECTION_MISSING" :
            len(left_hits)>1 || len(right_hits)>1 || len(local_hits)>2 ? "BODY_INTERSECTION_AMBIGUOUS" :
            !hit_order_ok || !body_order_ok ? "BODY_INTERSECTION_ORDER_INVALID" :
            hit_separation<=_cg_eps_len() ? "BODY_INTERVAL_DEGENERATE" : "PASS"
    )
    [state,code,tooth_index,target,frame,candidate,boundary,local_hits,first_hit,last_hit,accessibility,remote_hits];

/**
 * @function _cg_placement_result(points, arc, perimeter, body, modul, tooth_number, tooth_index, candidate, ...)
 * @brief Classify one candidate as placed, omitted or invalid.
 * @image ../images/tooth/placement.png Tooth placement result preview
 * @param points {array of points} Sampled closed pitch contour.
 * @param arc {array} Cumulative closed-contour arc-length table.
 * @param perimeter {number > 0} Total contour perimeter in mm.
 * @param body {array of points} Canonical body boundary.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param tooth_index {integer} Zero-based tooth index.
 * @param candidate {array} Cached validated local tooth candidate.
 * @param pressure_angle {angle, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param radial_root {boolean, default false} Use radial-root construction.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @return {array} Canonical placement result record.
 */
function _cg_placement_result(points,arc,perimeter,body,modul,tooth_number,tooth_index,candidate,pressure_angle=20,tooth_phase=0,radial_root=false,backlash=undef,clearance=undef) =
    let(
        tooth_pitch=perimeter/tooth_number,
        target=perimeter*(tooth_index+.25+tooth_phase/360)/tooth_number,
        frame=_cg_local_frame_for_closed_arc(points,arc,perimeter,target),
        frame_base_code=_cg_frame_failure_code(frame),
        frame_code=frame_base_code=="PASS" ? _cg_frame_continuity_failure_code(points,arc,perimeter,target,tooth_pitch) : frame_base_code
    )
    frame_code!="PASS" ? _cg_placement_invalid(tooth_index,target,frame,candidate,frame_code) :
    !candidate[0] ? _cg_placement_invalid(tooth_index,target,frame,candidate,candidate[1]) :
    _cg_placement_after_preflight(points,arc,perimeter,body,modul,tooth_number,tooth_index,candidate,pressure_angle,tooth_phase,radial_root,backlash,clearance,frame,tooth_pitch,target);

/*** @function _cg_tooth_pair_collisions(a, b)
 * @brief Find all segment intersections between two tooth boundaries.
 * @param a {array} First tooth boundary.
 * @param b {array} Second tooth boundary.
 * @return {array} Segment intersection records.
 */
function _cg_tooth_pair_collisions(a,b) = [
    for(i=[0:len(a)-1],j=[0:len(b)-1])
        let(
            p=a[i],q=a[(i+1)%len(a)],r=b[j],s=b[(j+1)%len(b)],
            crossing=_cg_bbox_segments_overlap(p,q,r,s) ? _cg_segment_intersection(p,q,r,s) : [false,[0,0],0,0],
            ab=_cg_vsub(q,p),cd=_cg_vsub(s,r),
            ab2=ab[0]*ab[0]+ab[1]*ab[1],
            t0=ab2>_cg_eps_len() ? (_cg_vsub(r,p)[0]*ab[0]+_cg_vsub(r,p)[1]*ab[1])/ab2 : 0,
            t1=ab2>_cg_eps_len() ? (_cg_vsub(s,p)[0]*ab[0]+_cg_vsub(s,p)[1]*ab[1])/ab2 : 0,
            overlap_start=max(0,min(t0,t1)),overlap_end=min(1,max(t0,t1)),
            collinear=ab2>_cg_eps_len() && abs(_cg_cross2(ab,cd))<=_cg_eps_intersect()
                && abs(_cg_cross2(_cg_vsub(r,p),ab))<=_cg_eps_intersect()
                && overlap_end-overlap_start>_cg_eps_intersect(),
            hit=crossing[0] ? crossing : collinear ? [true,_cg_vlerp(p,q,(overlap_start+overlap_end)/2),0,0] : [false,[0,0],0,0]
        ) if(hit[0]) [i,j,hit[1]]
];

/*** @function _cg_point_on_segment(point, a, b)
 * @brief Test whether a point lies on a segment within the geometry tolerance.
 * @param point {point} Candidate point.
 * @param a {point} Segment start.
 * @param b {point} Segment end.
 * @return {boolean} True when the point lies on the segment.
 */
function _cg_point_on_segment(point,a,b) =
    abs(_cg_cross2(_cg_vsub(point,a),_cg_vsub(b,a)))<=_cg_eps_intersect()
    && point[0]>=min(a[0],b[0])-_cg_eps_intersect() && point[0]<=max(a[0],b[0])+_cg_eps_intersect()
    && point[1]>=min(a[1],b[1])-_cg_eps_intersect() && point[1]<=max(a[1],b[1])+_cg_eps_intersect();

/*** @function _cg_point_in_polygon_strict(point, polygon_points)
 * @brief Test strict containment, excluding points on the polygon boundary.
 * @param point {point} Candidate point.
 * @param polygon_points {array} Closed polygon.
 * @return {boolean} True when the point is strictly inside the polygon.
 */
function _cg_point_in_polygon_strict(point,polygon_points) =
    _cg_point_in_polygon(point,polygon_points)
    && len([for(i=[0:len(polygon_points)-1])
        if(_cg_point_on_segment(point,polygon_points[i],polygon_points[(i+1)%len(polygon_points)])) 1])==0;

/*** @function _cg_tooth_containment_collisions(a, b)
 * @brief Detect one tooth boundary contained inside the other.
 * @param a {array of points} First tooth boundary.
 * @param b {array of points} Second tooth boundary.
 * @return {array} Containment witnesses.
 */
function _cg_tooth_containment_collisions(a,b) =
    _cg_point_in_polygon_strict(a[0],b) ? [[-1,-1,a[0]]] :
    _cg_point_in_polygon_strict(b[0],a) ? [[-1,-1,b[0]]] : [];

/*** @function _cg_tooth_contact_is_permitted(a, b, hit)
 * @brief Permit only a shared endpoint contact between tooth boundaries.
 * @param a {array of points} First tooth boundary.
 * @param b {array of points} Second tooth boundary.
 * @param hit {array} Segment collision record.
 * @return {boolean} True only for an endpoint-only shared boundary contact.
 */
function _cg_tooth_contact_is_permitted(a,b,hit) =
    hit[0]>=0 && hit[1]>=0
    && (_cg_vlen(_cg_vsub(hit[2],a[hit[0]]))<=_cg_eps_intersect()
        || _cg_vlen(_cg_vsub(hit[2],a[(hit[0]+1)%len(a)]))<=_cg_eps_intersect())
    && (_cg_vlen(_cg_vsub(hit[2],b[hit[1]]))<=_cg_eps_intersect()
        || _cg_vlen(_cg_vsub(hit[2],b[(hit[1]+1)%len(b)]))<=_cg_eps_intersect());

/*** @function _cg_tooth_top_collisions(a, b)
 * @brief Find collisions between the top edges of two tooth boundaries.
 * @param a {array} First tooth boundary.
 * @param b {array} Second tooth boundary.
 * @return {array} Top-edge collision records.
 */
function _cg_tooth_top_collisions(a,b) =
    len(a)<4 || len(b)<4 ? [] :
    let(top_a=floor((len(a)-1)/2),top_b=floor((len(b)-1)/2),
        p=a[top_a],q=a[(top_a+1)%len(a)],r=b[top_b],s=b[(top_b+1)%len(b)],
        hit=_cg_bbox_segments_overlap(p,q,r,s) ? _cg_segment_intersection(p,q,r,s) : [false,[0,0],0,0],
        collinear=_cg_bbox_segments_overlap(p,q,r,s)
            && abs(_cg_cross2(_cg_vsub(q,p),_cg_vsub(r,p)))<=_cg_eps_intersect()
            && abs(_cg_cross2(_cg_vsub(q,p),_cg_vsub(s,p)))<=_cg_eps_intersect())
    (hit[0] || collinear)
        && !_cg_tooth_contact_is_permitted(a,b,[top_a,top_b,hit[0] ? hit[1] : _cg_vlerp(p,q,.5)])
        ? [[top_a,top_b,hit[0] ? hit[1] : _cg_vlerp(p,q,.5)]] : [];

/*** @function _cg_tooth_order_failures(placements)
 * @brief Detect non-monotone indices among accepted placements.
 * @param placements {array} Placement records.
 * @return {array} Placement-order failure records.
 */
function _cg_tooth_order_failures(placements) =
    let(placed=[for(p=placements) if(p[0]=="placed") p])
    len(placed)<2 ? [] : [for(i=[0:len(placed)-2])
        if(placed[i][2] >= placed[i+1][2]) ["TOOTH_ORDER_CONFLICT",placed[i][2],placed[i+1][2]]];

/*** @function _cg_tooth_non_top_collisions(a, b)
 * @brief Filter top-edge contacts from complete tooth-pair collisions.
 * @param a {array} First tooth boundary.
 * @param b {array} Second tooth boundary.
 * @return {array} Non-top collision records.
 */
function _cg_tooth_non_top_collisions(a,b) = concat(
    [for(hit=_cg_tooth_pair_collisions(a,b))
        if(!(len(a)>=4 && len(b)>=4
            && hit[0]==floor((len(a)-1)/2) && hit[1]==floor((len(b)-1)/2))
            && !_cg_tooth_contact_is_permitted(a,b,hit)) hit],
    _cg_tooth_containment_collisions(a,b)
);

/**
 * @function _cg_adjacent_contact_region
 * @brief Return whether adjacent-tooth witnesses form one compact shared contact.
 * @param hits {array} Non-top collision witnesses.
 * @param modul {number > 0} Tooth module in mm.
 * @return {boolean} True only for one local contact region.
 */
function _cg_adjacent_contact_region(hits,modul) =
    len(hits)>0
    && len([for(hit=hits)
        if(_cg_vlen(_cg_vsub(hit[2],hits[0][2])) <= modul/4) 1])==len(hits);

/**
 * @function _cg_final_boundary_collisions
 * @brief Run broad-phase and exact checks for every nearby placed-tooth pair.
 * @param boundaries {array} Placed tooth boundaries.
 * @param points {array of points} Sampled pitch contour.
 * @param arc {array} Pitch-curve arc-length table.
 * @param perimeter {number > 0} Pitch-curve perimeter.
 * @param tooth_pitch {number > 0} Arc distance between teeth.
 * @return {array} Boundary collision records.
 */
function _cg_final_boundary_collisions(placements,modul,clearance=undef) =
    let(
        placed=[for(p=placements) if(p[0]=="placed") p],
        tooth_height=_cg_dedendum(modul,clearance)+_cg_addendum(modul),
        search_radius=2*tooth_height,
        pair_order=concat(
            len(placed)>2 ? [[0,len(placed)-1]] : [],
            len(placed)>1 ? [for(i=[0:len(placed)-2]) [i,i+1]] : [],
            len(placed)>3 ? [for(delta=[2:len(placed)-2]) for(i=[0:len(placed)-delta-1]) [i,i+delta]] : []
        )
    )
    len(placed)<2 ? [] : concat(
        [for(pair=pair_order)
            let(i=pair[0],j=pair[1],source_distance=_cg_vlen(_cg_vsub(placed[i][4][0],placed[j][4][0])),
                adjacent=(j==i+1 || (i==0 && j==len(placed)-1)),
                boundary_a=len(placed[i][6])<4 ? placed[i][6] : _cg_trim_tooth_boundary(placed[i][6],placed[i][8],placed[i][9]),
                boundary_b=len(placed[j][6])<4 ? placed[j][6] : _cg_trim_tooth_boundary(placed[j][6],placed[j][8],placed[j][9]),
                hits=_cg_tooth_non_top_collisions(boundary_a,boundary_b),
                remaining_hits=adjacent && len(boundary_a)>8 && len(boundary_b)>8 && _cg_adjacent_contact_region(hits,modul) ? [] : hits)
            if(source_distance<=search_radius)
                for(hit=remaining_hits) ["TOOTH_COLLISION",placed[i][2],placed[j][2],hit,source_distance,search_radius,placed[i][3],placed[j][3]]],
        [for(pair=pair_order)
            let(i=pair[0],j=pair[1],source_distance=_cg_vlen(_cg_vsub(placed[i][4][0],placed[j][4][0])),
                boundary_a=len(placed[i][6])<4 ? placed[i][6] : _cg_trim_tooth_boundary(placed[i][6],placed[i][8],placed[i][9]),
                boundary_b=len(placed[j][6])<4 ? placed[j][6] : _cg_trim_tooth_boundary(placed[j][6],placed[j][8],placed[j][9]))
            if(source_distance<=search_radius)
                let(top_hits=_cg_tooth_top_collisions(boundary_a,boundary_b))
                for(hit=top_hits) ["TOOTH_TOP_OVERLAP",placed[i][2],placed[j][2],hit,source_distance,search_radius,placed[i][3],placed[j][3]]]
    );
