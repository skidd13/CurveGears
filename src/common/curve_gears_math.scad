/***
 * @module Curve Gears Math
 * @brief Shared body assembly and boundary construction helpers.
 *
 * This layer connects pitch-curve placement to the public one-extrusion gear
 * contract. Its functions and modules are internal implementation primitives.
 */
include <../tooth/placement.scad>

// Gear-layer responsibilities begin here. Tooth generation and tooth
// placement are separately includable; this file owns body assembly and the
// public one-extrusion boundary contract.

/**
 * @module _cg_assert_gear_inputs
 * @brief Validate common pitch-to-gear inputs before geometry construction.
 * @param points {array of points} Sampled closed pitch contour.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle} Involute pressure angle in degrees.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param mate_points {undef or array of points} Optional second pitch contour for pair validation.
 */
module _cg_assert_gear_inputs(points,modul,tooth_number,bore,pressure_angle,clearance=undef,mate_points=undef) {
    assert(modul > 0,"module must be positive");
    assert(bore >= 0,"bore must be non-negative");
    assert(pressure_angle > 0 && pressure_angle < 90,"pressure angle must be between 0 and 90");
    assert(is_undef(clearance) || clearance >= 0,"clearance must be non-negative");
    assert(len(points) >= 8,"_cg_gear_2d_from_pitch_points: at least 8 pitch samples are required");
    if(!is_undef(mate_points))
        assert(len(mate_points) >= 8,"_cg_gear_2d_from_pitch_points: at least 8 pitch samples are required");
    assert(tooth_number >= 3 && floor(tooth_number)==tooth_number,"_cg_gear_2d_from_pitch_points: tooth_number must be an integer >= 3");
}

/***
 * @function _cg_tooth_phase_fraction(tooth_phase)
 * @brief Convert a public tooth phase in degrees to one contour-turn fraction.
 * @param tooth_phase {angle} Tooth placement phase in degrees.
 * @return {number} Fraction of one contour turn.
 */
function _cg_tooth_phase_fraction(tooth_phase) = tooth_phase/360;

/***
 * @function _cg_body_interval_before(body, arc, perimeter, start_s, end_s)
 * @brief Return canonical body vertices before a tooth splice interval.
 * @param body {array} Canonical body boundary points.
 * @param arc {array} Body arc-length table.
 * @param perimeter {number > 0} Body perimeter in mm.
 * @param start_s {number} Start arc position in mm.
 * @param end_s {number} End arc position in mm.
 * @return {array} Body vertices inside the requested interval.
 */
function _cg_body_interval_before(body,arc,perimeter,start_s,end_s) =
    let(
        n=len(body),
        wrapped_start=start_s-perimeter*floor(start_s/perimeter),
        wrapped_end=end_s-perimeter*floor(end_s/perimeter),
        start_cycle=floor(start_s/perimeter),
        end_cycle=floor(end_s/perimeter),
        start_u=_cg_interp_x_for_y(arc,wrapped_start),
        end_u=_cg_interp_x_for_y(arc,wrapped_end),
        start_index=min(n-1,max(0,floor(start_u))),
        end_u_unwrapped=end_u+(end_cycle-start_cycle)*n,
        candidate_count=max(0,min(n,floor(end_u_unwrapped)-start_index))
    )
    candidate_count==0 ? [] : [for(q=[0:candidate_count-1])
        let(k=(start_index+1+q)%n,base=arc[k][1],
            shifted=base+perimeter*ceil((start_s-base+_cg_eps_len())/perimeter))
        if(shifted>start_s+_cg_eps_len() && shifted<end_s-_cg_eps_len())
            _cg_point_for_closed_arc(body,arc,shifted)];

/***
 * @function _cg_trim_tooth_boundary(boundary, start_hit, end_hit)
 * @brief Trim a placed tooth boundary to its selected body intersections.
 * @param boundary {array} Placed tooth boundary points.
 * @param start_hit {array} First body intersection record.
 * @param end_hit {array} Second body intersection record.
 * @return {array} Trimmed tooth boundary.
 */
function _cg_trim_tooth_boundary(boundary,start_hit,end_hit) =
    concat(
        [start_hit[0]],
        [for(i=[start_hit[1]+1:end_hit[1]])
            if(_cg_vlen(_cg_vsub(boundary[i],start_hit[0])) > _cg_eps_len()
                && _cg_vlen(_cg_vsub(boundary[i],end_hit[0])) > _cg_eps_len()) boundary[i]],
        [end_hit[0]]
    );

/***
 * @function _cg_final_outline_from_placements(body, arc, perimeter, placements, tooth_pitch)
 * @brief Replace canonical body intervals with ordered placed teeth.
 * @param body {array} Canonical body boundary points.
 * @param arc {array} Body arc-length table.
 * @param perimeter {number > 0} Body perimeter in mm.
 * @param placements {array} Placement records.
 * @param tooth_pitch {number > 0} Arc-length pitch used to clip each splice cell.
 * @return {array} Final assembled outline points.
 */
function _cg_final_outline_from_placements(body,arc,perimeter,placements,tooth_pitch=undef) =
    let(placed=[for(p=placements) if(p[0]=="placed") p])
    len(placed)==0 ? body :
    [
        for(i=[0:len(placed)-1])
            let(
                current=placed[i],
                previous=placed[(i-1+len(placed))%len(placed)],
                current_interval=_cg_splice_interval(current,perimeter,tooth_pitch),
                previous_interval=_cg_splice_interval(previous,perimeter,tooth_pitch),
                previous_end_raw=previous_interval[1],
                offset=current_interval[0] <= previous_end_raw ? perimeter : 0,
                previous_end=previous_end_raw+offset,
                start_s=current_interval[0]+offset,
                body_interval=_cg_body_interval_before(body,arc,perimeter,previous_end,start_s),
                tooth_interval=_cg_trim_tooth_boundary(current[6],current[8],current[9]),
                interval=concat(body_interval,tooth_interval)
            )
            for(p=interval) p
    ];

/*** @function _cg_has_zero_edge(points)
 * @brief Detect zero-length edges in a closed point list.
 * @param points {array} Closed polygon points.
 * @return {boolean} True when any adjacent edge is below the length tolerance.
 */
function _cg_has_zero_edge(points) =
    max([for(i=[0:len(points)-1])
        _cg_vlen(_cg_vsub(points[(i+1)%len(points)],points[i])) <= _cg_eps_len() ? 1 : 0]) == 1;
/*** @function _cg_has_immediate_backtrack(points)
 * @brief Detect an immediate two-edge reversal in a point list.
 * @param points {array} Closed polygon points.
 * @return {boolean} True when a point immediately backtracks to its predecessor.
 */
function _cg_has_immediate_backtrack(points) =
    len(points)<3 ? false : max([for(i=[0:len(points)-1])
        _cg_vlen(_cg_vsub(points[i],points[(i+2)%len(points)])) <= _cg_eps_intersect() ? 1 : 0]) == 1;
/*** @function _cg_same_edge(a, b, c, d)
 * @brief Compare two undirected line segments within the positional tolerance.
 * @param a {array} First endpoint of the first segment.
 * @param b {array} Second endpoint of the first segment.
 * @param c {array} First endpoint of the second segment.
 * @param d {array} Second endpoint of the second segment.
 * @return {boolean} True when the segments have the same endpoints.
 */
function _cg_same_edge(a,b,c,d) =
    (_cg_vlen(_cg_vsub(a,c))<=_cg_eps_len() && _cg_vlen(_cg_vsub(b,d))<=_cg_eps_len())
    || (_cg_vlen(_cg_vsub(a,d))<=_cg_eps_len() && _cg_vlen(_cg_vsub(b,c))<=_cg_eps_len());
/*** @function _cg_has_duplicate_edge(points)
 * @brief Detect non-adjacent duplicate edges in a closed point list.
 * @param points {array} Closed polygon points.
 * @return {boolean} True when a non-adjacent edge is duplicated.
 */
function _cg_has_duplicate_edge(points) =
    len(points)<4 ? false : max([for(i=[0:len(points)-2]) for(j=[i+1:len(points)-1])
        let(adjacent=j==i+1 || (i==0 && j==len(points)-1),
            duplicate=!adjacent
                && _cg_bbox_segments_overlap(points[i],points[(i+1)%len(points)],points[j],points[(j+1)%len(points)])
                && _cg_same_edge(points[i],points[(i+1)%len(points)],points[j],points[(j+1)%len(points)]))
        duplicate ? 1 : 0]) == 1;
/*** @function _cg_merge_point_count(points, target)
 * @brief Count points that coincide with a target within the merge tolerance.
 * @param points {array} Point list.
 * @param target {array} Target point.
 * @return {integer} Number of coincident points.
 */
function _cg_merge_point_count(points,target) = len([for(p=points) if(_cg_vlen(_cg_vsub(p,target))<=_cg_eps_len()) 1]);

/***
 * @function _cg_assembled_component_failures(outline, placements)
 * @brief Check tooth/body ownership before final polygon scans.
 * @param outline {array} Assembled outline points.
 * @param placements {array} Placement records.
 * @return {array} Assembly failure records, or an empty array.
 */
function _cg_assembled_component_failures(outline,placements) =
    _cg_has_immediate_backtrack(outline) ? [["POLYGON_BACKTRACK"]] :
    let(
        placed=[for(p=placements) if(p[0]=="placed") p],
        merge_counts=[for(p=placed) _cg_merge_point_count(outline,p[8][0])],
        missing=len(placed)==0 ? [] : [for(i=[0:len(placed)-1]) if(merge_counts[i]==0)
            ["MERGE_MISSING_TOOTH",placed[i][2],placed[i][8][0]]],
        duplicate=len(placed)==0 ? [] : [for(i=[0:len(placed)-1]) if(merge_counts[i]>1)
            ["MERGE_DUPLICATE_TOOTH",placed[i][2],placed[i][8][0]]]
    )
    concat(
        missing,
        duplicate,
        [for(p=placements) if(p[0]=="placed" && len(_cg_polygon_intersections(_cg_trim_tooth_boundary(p[6],p[8],p[9])))>0)
            ["POLYGON_SELF_INTERSECTION",p[2]]]
    );

/**
 * @function _cg_adjacent_contact_points
 * @brief Collect witnesses for accepted compact adjacent contacts.
 * @param placements {array} Placement records.
 * @param modul {number > 0} Tooth module in mm.
 * @return {array} Contact witness points allowed at assembly joins.
 */
function _cg_adjacent_contact_points(placements,modul) =
    let(placed=[for(p=placements) if(p[0]=="placed") p])
    len(placed)<2 ? [] : [
        for(i=[0:len(placed)-1])
            let(j=(i+1)%len(placed),
                boundary_a=_cg_trim_tooth_boundary(placed[i][6],placed[i][8],placed[i][9]),
                boundary_b=_cg_trim_tooth_boundary(placed[j][6],placed[j][8],placed[j][9]),
                hits=_cg_tooth_non_top_collisions(boundary_a,boundary_b))
            if(j==i+1 || (i==len(placed)-1 && j==0))
                if(_cg_adjacent_contact_region(hits,modul))
                    for(hit=hits) hit[2]
    ];

function _cg_point_near_any(point,points,radius) =
    len([for(candidate=points) if(_cg_vlen(_cg_vsub(point,candidate))<=radius) 1])>0;

/***
 * @function _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, ...)
 * @brief Build and validate one two-dimensional gear boundary from pitch points.
 * @param points {array} Closed sampled pitch-curve points.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param radial_root {boolean, default false} Use radial-root construction.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Validated two-dimensional gear boundary.
 */
module _cg_gear_2d_from_pitch_points(points,modul,tooth_number,bore,pressure_angle=20,tooth_phase=0,radial_root=false,backlash=undef,clearance=undef,body_only=false,prepared_state=undef) {
    _cg_assert_gear_inputs(points,modul,tooth_number,bore,pressure_angle,clearance);
    state=prepared_state;
    arc=is_undef(state) ? _cg_polyline_arc_table(points) : state[1];
    perimeter=arc[len(arc)-1][1];
    body_outline=is_undef(state) ? _cg_canonical_body_polyline(points,arc,perimeter,_cg_dedendum(modul,clearance),radial_root) : state[3];
    assert(perimeter > 0,"_cg_gear_2d_from_pitch_points: pitch perimeter must be positive");
    assert(_cg_polyline_finite(body_outline),"stage=body severity=error code=BODY_NONFINITE_GEOMETRY eps_len=1e-7");
    assert(len(body_outline)>=3,"stage=body severity=error code=BODY_OPEN effective_points<3");
    assert(!_cg_has_zero_edge(body_outline),"stage=body severity=error code=BODY_DUPLICATE_SEGMENT eps_len=1e-7");
    assert(!_cg_has_duplicate_edge(body_outline),"stage=body severity=error code=BODY_DUPLICATE_SEGMENT eps_len=1e-7");
    assert(_cg_polygon_area(body_outline)>_cg_eps_area(),"stage=body severity=error code=BODY_ZERO_AREA eps_area=1e-8");
    body_collisions=!is_undef(state) && len(state)>=12 ? state[6] : _cg_polygon_intersections(body_outline);
    body_collision=len(body_collisions)>0 ? body_collisions[0] : [0,0,[0,0]];
    assert(len(body_collisions)==0,
        str("stage=body severity=error code=BODY_SELF_INTERSECTION eps_intersect=",_cg_eps_intersect()," segment=",body_collision[0],"/",body_collision[1]," point=",body_collision[2]));

    if (body_only) {
        difference() {
            polygon(body_outline);
            if (bore > 0) circle(d=bore);
        }
    } else {
        placement_state=is_undef(state) ? _cg_tooth_placement_state(points,arc,perimeter,body_outline,modul,tooth_number,pressure_angle,tooth_phase,radial_root,backlash,clearance) : [state[4],state[5]];
        candidate=placement_state[0];
        placements=placement_state[1];
        invalid=[for(p=placements) if(p[0]=="invalid") p];
        placed_count=len([for(p=placements) if(p[0]=="placed") p]);
        inaccessible_count=len([for(p=placements) if(p[0]=="omitted_inaccessible") p]);
        echo(str("stage=placement severity=info code=PLACEMENT_SUMMARY message=placement_summary total=",len(placements)," placed=",placed_count," omitted_inaccessible=",inaccessible_count," invalid=",len(invalid)));
        for(p=placements) if(p[0]!="placed")
            echo(str("stage=placement severity=",p[0]=="invalid" ? "error" : "info"," code=",p[1]," message=placement_evaluation state=",p[0]," index=",p[2]," target=",p[3]," position=",p[4][0]," tangent=",p[4][1]," normal=",p[4][2]," pitch_radius=",_cg_vlen(p[4][0])," top_width=",p[5][2]," top_left=",p[5][6]," top_right=",p[5][7]," top_left_hit_count=",len(p[5][9])," top_right_hit_count=",len(p[5][10])," intersection_count=",len(p[7])," remote_intersection_count=",len(p[11])," obstruction_segment=",p[10][1]>=0 ? p[10][1] : len(p[11])>0 ? p[11][0][2] : -1," obstruction_point=",p[10][1]>=0 ? p[10][2] : len(p[11])>0 ? p[11][0][0] : [0,0]," available_clearance=",p[10][1]>=0 ? p[10][3] : len(p[11])>0 ? 0 : p[10][3]," required_clearance=",p[10][4]," eps_len=",_cg_eps_len()," eps_angle=",_cg_eps_angle()," eps_intersect=",_cg_eps_intersect()));
        assert(len(invalid)==0,
            str("stage=placement severity=error code=TOOTH_INVALID index=",invalid[0][2]," detail=",invalid[0][1]," eps_len=",_cg_eps_len()," eps_intersect=",_cg_eps_intersect()));
        order_failures=_cg_tooth_order_failures(placements);
        assert(len(order_failures)==0,
            str("stage=collision severity=error code=TOOTH_ORDER_CONFLICT message=placement order is not monotone first=",order_failures[0][1]," second=",order_failures[0][2]));
        tooth_pitch=perimeter/tooth_number;
        splice_pitch=radial_root ? undef : tooth_pitch;
        splice_failures=_cg_splice_failures(placements,perimeter,splice_pitch);
        splice_failure=len(splice_failures)>0 ? splice_failures[0] : ["PASS",[],[]];
        assert(len(splice_failures)==0,
            str("stage=splice severity=error code=",splice_failure[0]," first=",splice_failure[1]," second=",splice_failure[2]," eps_len=",_cg_eps_len()," eps_intersect=",_cg_eps_intersect()));
        cached_final=!is_undef(state) && len(state)>=12;
        collisions=cached_final ? state[8] : _cg_final_boundary_collisions(placements,modul,clearance);
        if (len(collisions)>0)
            echo(str("stage=collision severity=error code=",collisions[0][0]," message=placed tooth pair conflict pair=",collisions[0][1],"/",collisions[0][2]," target=",collisions[0][6],"/",collisions[0][7]," source_distance=",collisions[0][4]," search_radius=",collisions[0][5]," segments=",collisions[0][3][0],"/",collisions[0][3][1]," intersection=",collisions[0][3][2]," eps_intersect=",_cg_eps_intersect()));
        assert(len(collisions)==0,
            str("stage=collision severity=error code=",len(collisions)>0 ? collisions[0][0] : "TOOTH_COLLISION"," message=placed tooth pair conflict eps_intersect=",_cg_eps_intersect()," search_radius=2*tooth_height"));
        outline=cached_final ? state[7] : _cg_final_outline_from_placements(body_outline,arc,perimeter,placements,splice_pitch);
        assembly_failures=cached_final ? state[9] : _cg_assembled_component_failures(outline,placements);
        assembly_failure=len(assembly_failures)>0 ? assembly_failures[0] : ["PASS"];
        assert(len(assembly_failures)==0,
            str("stage=polygon severity=error code=",assembly_failure[0]," tooth=",len(assembly_failure)>1 ? assembly_failure[1] : -1," eps_intersect=",_cg_eps_intersect()));
        assert(_cg_polyline_finite(outline),"stage=polygon severity=error code=POLYGON_NONFINITE eps_len=1e-7");
        assert(len(outline)>=3,"stage=polygon severity=error code=POLYGON_OPEN effective_points<3");
        assert(!_cg_has_zero_edge(outline),"stage=polygon severity=error code=POLYGON_ZERO_EDGE eps_len=1e-7");
        assert(!_cg_has_immediate_backtrack(outline),"stage=polygon severity=error code=POLYGON_BACKTRACK eps_intersect=1e-7");
        assert(!_cg_has_duplicate_edge(outline),"stage=polygon severity=error code=POLYGON_DUPLICATE_EDGE eps_len=1e-7");
        assert(_cg_polygon_area(outline)>_cg_eps_area(),"stage=polygon severity=error code=POLYGON_ZERO_AREA eps_area=1e-8");
        allowed_contact_points=_cg_adjacent_contact_points(placements,modul);
        final_intersections=cached_final ? state[10] : [for(hit=_cg_polygon_intersections(outline))
            if(!_cg_point_near_any(hit[2],allowed_contact_points,modul/4)) hit];
        final_intersection=len(final_intersections)>0 ? final_intersections[0] : [0,0,[0,0]];
        assert(len(final_intersections)==0,
            str("stage=polygon severity=error code=POLYGON_SELF_INTERSECTION eps_intersect=",_cg_eps_intersect()," segment=",final_intersection[0],"/",final_intersection[1]," point=",final_intersection[2]));
        final_signed_area=cached_final ? state[11] : _cg_signed_area(outline);
        final_winding=final_signed_area>_cg_eps_area() ? 1 : final_signed_area < -_cg_eps_area() ? -1 : 0;
        assert(final_winding!=0,
            str("stage=polygon severity=error code=POLYGON_WINDING_INVALID signed_area=",final_signed_area," eps_area=",_cg_eps_area()));
        difference() {
            polygon(outline);
            if (bore > 0) circle(d=bore);
        }
    }
}

/***
 * @function _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, ...)
 * @brief Extrude a validated two-dimensional gear boundary.
 * @param points {array} Closed sampled pitch-curve points.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param radial_root {boolean, default false} Use radial-root construction.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Extruded gear.
 */
module _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle=20,tooth_phase=0,radial_root=false,backlash=undef,clearance=undef,body_only=false,prepared_state=undef) {
    assert(width > _cg_eps_len(),
        str("stage=extrusion severity=error code=EXTRUSION_HEIGHT_INVALID message=width must be positive width=",width," eps_len=",_cg_eps_len()));
    let($fn=$fn==0 ? _cg_default_fn : $fn)
    linear_extrude(height=width,convexity=10)
        _cg_gear_2d_from_pitch_points(points,modul,tooth_number,bore,pressure_angle,tooth_phase,radial_root,backlash,clearance,body_only,prepared_state);
}

/**
 * @module _cg_gear_from_state
 * @brief Extrude a gear from an already prepared common geometry state.
 * @param state {array} Shared pitch, body, candidate, and placement state.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param radial_root {boolean, default false} Use radial-root construction.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param body_only {boolean, default false} Emit the body without teeth.
 */
module _cg_gear_from_state(state,modul,tooth_number,width,bore,pressure_angle=20,tooth_phase=0,radial_root=false,backlash=undef,clearance=undef,body_only=false) {
    _cg_gear_from_pitch_points(state[0],modul,tooth_number,width,bore,pressure_angle,tooth_phase,radial_root,backlash,clearance,body_only,state);
}
