include <base.scad>

/***
 * @function _cg_cusp_indices
 * @brief Return the tooth indices aligned with the hypocycloid cusps.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array of integer} Cusp-aligned tooth indices.
 */
function _cg_cusp_indices(tooth_number,cusps=3) = [for(i=[0:cusps-1]) i*tooth_number/cusps];
/***
 * @function _cg_cusp_body_branch_point
 * @brief Find a radial-root point on one hypocycloid branch.
 * @param a {number > 0} Rolling-circle radius in millimetres.
 * @param t {angle} Hypocycloid parameter in degrees.
 * @param dedendum {number >= 0} Tooth-root depth in millimetres.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array} Cartesian body point in millimetres.
 */
function _cg_cusp_body_branch_point(a,t,dedendum,cusps=3) =
    let(x=a*((cusps-1)*cos(t)+cos((cusps-1)*t)),y=a*((cusps-1)*sin(t)-sin((cusps-1)*t)),radius=_cg_vlen([x,y]),root=max(radius-dedendum,.02*dedendum))
        [x*root/radius,y*root/radius];
/***
 * @function _cg_cusp_parameter_for_body_y
 * @brief Solve for the hypocycloid parameter at a requested body-branch height.
 * @param a {number > 0} Rolling-circle radius in millimetres.
 * @param target {number} Target Cartesian y coordinate in millimetres.
 * @param dedendum {number >= 0} Tooth-root depth in millimetres.
 * @param lo {angle, default 0} Lower parameter bound in degrees.
 * @param hi {undef or angle, default undef} Upper bound in degrees; undef uses 180/cusps.
 * @param i {integer >= 0, default 0} Recursion iteration.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {angle} Solved hypocycloid parameter in degrees.
 */
function _cg_cusp_parameter_for_body_y(a,target,dedendum,lo=0,hi=undef,i=0,cusps=3) =
    let(upper=is_undef(hi) ? 180/cusps : hi)
    i>=32 ? (lo+upper)/2 :
    let(mid=(lo+upper)/2)
        _cg_cusp_body_branch_point(a,mid,dedendum,cusps)[1]>target
            ? _cg_cusp_parameter_for_body_y(a,target,dedendum,lo,mid,i+1,cusps)
            : _cg_cusp_parameter_for_body_y(a,target,dedendum,mid,upper,i+1,cusps);
/***
 * @function _cg_cusp_tip_candidate
 * @brief Prepare the standard tooth profile and cusp-anchor dimensions.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param pressure_angle {0 < angle < 90} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array} Standard tooth candidate extended with cusp dimensions.
 */
function _cg_cusp_tip_candidate(modul,tooth_number,pressure_angle,backlash,clearance,cusps=3) =
    let(
        a=_cg_cusp_scale(modul,tooth_number,cusps),pitch_radius=modul*tooth_number/2,
        standard=_cg_reference_tooth_candidate(pitch_radius,modul,tooth_number,pressure_angle,backlash,clearance,true),
        reference=_cg_reference_tooth_local_flanks(pitch_radius,modul,tooth_number,pressure_angle,backlash,clearance,true),
        half_width=_cg_vlen(_cg_vsub(reference[1][0],reference[0][0]))/2,
        dedendum=_cg_dedendum(modul,clearance),
        t=_cg_cusp_parameter_for_body_y(a,half_width,dedendum,cusps=cusps),
        branch_arc=(4*a*(cusps-1)/cusps)*(1-cos(cusps*t/2)),
        body_root=_cg_cusp_body_branch_point(a,t,dedendum,cusps),
        inset=cusps*a+standard[4][1][0]-pitch_radius-body_root[0],
        height=_cg_addendum(modul),candidate=standard
    )
    concat(candidate,[[t,inset,branch_arc,"driver_cusp",height,[0,0],[0,0]]]);

/***
 * @function _cg_cusp_anchor_placement
 * @brief Place a standard tooth in the analytic cusp-axis frame and trim its shoulder interval.
 * @param points {array of points} Sampled hypocycloid pitch curve.
 * @param arc {array} Pitch-curve arc-length table.
 * @param perimeter {number > 0} Pitch-curve perimeter in millimetres.
 * @param body {array of points} Radial-root body polyline.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param index {integer >= 0} Tooth index at this cusp.
 * @param candidate {array} Prepared standard tooth candidate with cusp data.
 * @param phase {angle, default -90} Tooth-placement phase in degrees.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps.
 * @return {array} Validated cusp-anchor tooth placement record.
 */
function _cg_cusp_anchor_placement(points,arc,perimeter,body,modul,tooth_number,index,candidate,phase=-90,cusps=3) =
    let(
        target=perimeter*(index+.25+phase/360)/tooth_number,
        cusp_point=_cg_point_for_closed_arc(points,arc,target),
        winding=_cg_signed_area(points)>=0 ? 1 : -1,
        // The tangent is singular at a cusp; derive its radial frame from the
        // cusp index instead of constructing a sampled local frame.
        cusp_angle=360*index/tooth_number,
        cusp_normal=[cos(cusp_angle),sin(cusp_angle)],
        cusp_tangent=[-sin(cusp_angle),cos(cusp_angle)],
        inset=candidate[11][1],
        tooth_origin=_cg_vsub(cusp_point,[cusp_normal[0]*inset,cusp_normal[1]*inset]),
        frame=[tooth_origin,cusp_tangent,cusp_normal,winding],
        branch_arc=candidate[11][2],boundary=[for(p=candidate[8]) _cg_profile_point_at_frame(p,frame[0],frame[2],frame[1],modul*tooth_number/2)],
        left_s=target-branch_arc,right_s=target+branch_arc,
        // Preserve the established deltoid crop. Other cusp counts use exact
        // sampled-body/flank intersections: analytic shoulders can cross the
        // tiny root transition when projected onto a discretised body.
        hits=cusps==3 ? [] : _cg_unique_hits(_cg_tooth_body_intersections(boundary,body)),
        left_hits=[for(hit=hits) if(hit[1]<len(candidate[4])-1) concat(hit,[_cg_arc_near_target(_cg_body_arc_for_intersection(hit,arc),target,perimeter)])],
        right_hits=[for(hit=hits) if(hit[1]>=len(candidate[4])) concat(hit,[_cg_arc_near_target(_cg_body_arc_for_intersection(hit,arc),target,perimeter)])],
        left=cusps==3 ? [_cg_point_for_closed_arc(body,arc,left_s),0,_cg_arc_segment_index(arc,perimeter,left_s),1,0,left_s]
            : assert(len(left_hits)==1,"cusp_gear: cusp left flank must meet the body exactly once") left_hits[0],
        right=cusps==3 ? [_cg_point_for_closed_arc(body,arc,right_s),len(boundary)-3,_cg_arc_segment_index(arc,perimeter,right_s),1,0,right_s]
            : assert(len(right_hits)==1,"cusp_gear: cusp right flank must meet the body exactly once") right_hits[0])
    ["placed","CUSP_CURVE_ANCHOR",index,target,frame,candidate,boundary,[left,right],left,right,[false,-1,[0,0],0,0,frame,[]],[]];

/***
 * @function _cg_cusp_clear_shoulder_placement
 * @brief Classify an ordinary tooth as inaccessible when a cusp shoulder owns its splice interval.
 * @param placement {array} Ordinary tooth placement from the shared validator.
 * @param anchors {array} Prepared radial cusp-anchor placements.
 * @param perimeter {number > 0} Closed pitch-curve perimeter in millimetres.
 * @return {array} Original placement or an inaccessible placement with its diagnostic geometry retained.
 */
function _cg_cusp_clear_shoulder_placement(placement,anchors,perimeter) =
    placement[0]!="placed" ? placement :
    let(
        interval=_cg_splice_interval(placement,perimeter),
        conflicts=[for(anchor=anchors) for(cycle=[-1:1])
            let(owned=_cg_splice_interval(anchor,perimeter),
                shifted=[owned[0]+cycle*perimeter,owned[1]+cycle*perimeter,owned[2],owned[3]])
            if(_cg_splice_relation(interval,shifted)!="PASS") 1]
    )
    len(conflicts)==0 ? placement : concat(["omitted_inaccessible","CUSP_SHOULDER_OCCUPIED"],
        [for(i=[2:len(placement)-1]) placement[i]]);

/***
 * @function _cg_cusp_prepared_state
 * @brief Assemble ordinary and cusp-anchor teeth into one validated state.
 * @param points {array of points} Sampled hypocycloid pitch curve.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param pressure_angle {0 < angle < 90} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param tip_candidate {array} Prepared standard tooth candidate with cusp data.
 * @param phase {angle, default -90} Tooth-placement phase in degrees.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array} Validated complete cusp-gear geometry state.
 */
function _cg_cusp_prepared_state(points,modul,tooth_number,pressure_angle,backlash,clearance,tip_candidate,phase=-90,cusps=3) =
    let(
        arc=_cg_polyline_arc_table(points),perimeter=arc[len(arc)-1][1],
        body=_cg_canonical_body_polyline(points,_cg_dedendum(modul,clearance),true),
        cusp_indices=_cg_cusp_indices(tooth_number,cusps),
        standard=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,pressure_angle,backlash,clearance,true),
        cusp_placements=[for(i=cusp_indices)
            _cg_cusp_anchor_placement(points,arc,perimeter,body,modul,tooth_number,i,tip_candidate,phase,cusps)],
        ordinary=[for(i=[0:tooth_number-1]) if(len([for(c=cusp_indices) if(c==i) 1])==0)
            let(target=perimeter*(i+.25+phase/360)/tooth_number)
                _cg_cusp_clear_shoulder_placement(
                    _cg_placement_result(points,arc,perimeter,body,modul,tooth_number,i,standard,pressure_angle,phase,true,backlash,clearance),
                    cusp_placements,perimeter)],
        evaluated=concat(ordinary,cusp_placements),
        placements=[for(i=[0:tooth_number-1]) [for(p=evaluated) if(p[2]==i) p][0]]
    )
    _cg_tooth_geometry_state(points,modul,tooth_number,pressure_angle,phase,true,backlash,clearance,false,true,[standard,placements]);

/***
 * @function _cg_cusp_body_outline
 * @brief Build the cusp-family body outline with its integrated tip teeth.
 * @param state {array} Validated cusp gear state.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array of points} Closed body and cusp-tip outline.
 */
function _cg_cusp_body_outline(state,tooth_number,cusps=3) =
    let(cusp_indices=_cg_cusp_indices(tooth_number,cusps),tip_placements=[for(p=state[5]) if(len([for(i=cusp_indices) if(p[2]==i) 1])>0) p])
    _cg_final_outline_from_placements(state[3],state[1],state[2],tip_placements);
/***
 * @function _cg_cusp_state
 * @brief Construct the complete validated state for a cusp gear.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param pressure_angle {0 < angle < 90, default 20} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 720, divisible by cusps, default 720} Pitch-curve samples.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array} Validated cusp gear state.
 */
function _cg_cusp_state(modul,tooth_number,pressure_angle=20,backlash=undef,clearance=undef,samples=720,cusps=3) =
    let(
        scale=_cg_cusp_scale(modul,tooth_number,cusps),points=_cg_cusp_points(scale,samples,cusps),
        candidate=_cg_cusp_tip_candidate(modul,tooth_number,pressure_angle,backlash,clearance,cusps)
    )
        _cg_cusp_prepared_state(points,modul,tooth_number,pressure_angle,backlash,clearance,candidate,cusps=cusps);

/***
 * @function _cg_cusp_cross2
 * @brief Calculate the scalar 2D cross product of two vectors.
 * @param a {array of number} First 2D vector.
 * @param b {array of number} Second 2D vector.
 * @return {number} Scalar cross product.
 */
function _cg_cusp_cross2(a,b) = a[0]*b[1]-a[1]*b[0];
/***
 * @function _cg_cusp_ray_segment_radius
 * @brief Find a non-negative ray intersection radius on one outline segment.
 * @param a {array of number} First segment endpoint.
 * @param b {array of number} Second segment endpoint.
 * @param angle {angle} Ray direction in degrees.
 * @return {number} Intersection radius, or zero when there is no hit.
 */
function _cg_cusp_ray_segment_radius(a,b,angle) =
    let(direction=[cos(angle),sin(angle)],segment=_cg_vsub(b,a),denominator=_cg_cusp_cross2(direction,segment),
        u=abs(denominator)<=_cg_eps_len() ? -1 : _cg_cusp_cross2(a,direction)/denominator,
        radius=abs(denominator)<=_cg_eps_len() ? -1 : _cg_cusp_cross2(a,segment)/denominator)
    abs(denominator)>_cg_eps_len() && u>=-_cg_eps_len() && u<=1+_cg_eps_len() && radius>=0 ? radius : 0;
/***
 * @function _cg_cusp_radius_on_outline
 * @brief Find the furthest outline intersection along a radial direction.
 * @param outline {array of points} Closed gear outline.
 * @param angle {angle} Ray direction in degrees.
 * @return {number} Furthest intersection radius in millimetres.
 */
function _cg_cusp_radius_on_outline(outline,angle) =
    max([for(i=[0:len(outline)-1]) _cg_cusp_ray_segment_radius(outline[i],outline[(i+1)%len(outline)],angle)]);
/***
 * @function _cg_cusp_repeated_radii
 * @brief Sample outline radii for all repeated hypocycloid sectors.
 * @param outline {array of points} Pitch curve or closed driver outline.
 * @param samples {integer >= 3, divisible by cusps} Total angular sample count.
 * @param midpoint {boolean} Sample at interval midpoints when true.
 * @param pitch_offset {number} Radial offset in millimetres.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array of number} Repeated radius samples.
 */
function _cg_cusp_repeated_radii(outline,samples,midpoint,pitch_offset,cusps=3) =
    let(count=samples/cusps,sector=[for(i=[0:count-1])
        _cg_cusp_radius_on_outline(outline,360*(i+(midpoint ? .5 : 0))/samples)+pitch_offset])
    [for(k=[0:cusps-1]) each sector];
/***
 * @function _cg_cusp_pair_motion_geometry
 * @brief Build the validated cusp driver, radial motion data, solved distance, and motion table from the unmodified hypocycloid pitch curve.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param pressure_angle {0 < angle < 90} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 120, divisible by cusps} Motion sampling density.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @return {array} Driver state, radii, solved distance, and integrated motion.
 */
function _cg_cusp_pair_motion_geometry(modul,tooth_number,pressure_angle,backlash,clearance,samples,cusps=3) =
    assert(cusps>=3 && floor(cusps)==cusps,"cusp_gear: cusps must be an integer >= 3")
    assert(tooth_number>=cusps && floor(tooth_number)==tooth_number && tooth_number%cusps==0,
        "cusp_gear: tooth_number must be an integer divisible by cusps")
    assert(samples>=120 && floor(samples)==samples && samples%cusps==0,
        "cusp_gear: samples must be an integer >= 120 and divisible by cusps")
    let(
        scale=_cg_cusp_scale(modul,tooth_number,cusps),driver_state=_cg_cusp_state(modul,tooth_number,pressure_angle,backlash,clearance,samples,cusps),
        pitch_curve=_cg_cusp_points(scale,samples,cusps),
        driver_radii=_cg_cusp_repeated_radii(pitch_curve,samples,false,0,cusps),
        mid_radii=_cg_cusp_repeated_radii(pitch_curve,samples,true,0,cusps),
        maximum=max(driver_radii),distance=_cg_solve_mate_distance(mid_radii,maximum+.01,(2*cusps+1)*scale),
        integration=_cg_motion_integration_state(driver_radii,mid_radii,distance)
    )
    [driver_state,driver_radii,mid_radii,distance,integration];

/***
 * @function _cg_cusp_build
 * @brief Construct the validated cusp body or complete gear.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3, divisible by cusps} Number of teeth.
 * @param width {number > 0} Extrusion width in millimetres.
 * @param bore {number >= 0} Centre bore diameter in millimetres.
 * @param pressure_angle {0 < angle < 90, default 20} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 720, divisible by cusps, default 720} Pitch-curve sample count.
 * @param orientation {angle, default 0} Display rotation in degrees.
 * @param body_only {boolean, default false} Emit the integrated body without ordinary teeth.
 * @param is_2d {boolean, default false} Emit a planar outline instead of an extrusion.
 * @param body_offset {number, default 0} Signed planar-body offset in millimetres.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 */
module _cg_cusp_build(modul,tooth_number,width,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0,cusps=3) {
    assert(cusps>=3 && floor(cusps)==cusps,"cusp_gear: cusps must be an integer >= 3");
    assert(tooth_number>=cusps && floor(tooth_number)==tooth_number && tooth_number%cusps==0,
        "cusp_gear: tooth_number must be an integer divisible by cusps so each cusp aligns with a tooth");
    _cg_assert_samples(samples,"cusp_gear: samples must be an integer >= 720 for the validated cusp teeth",720);
    assert(samples%cusps==0,"cusp_gear: samples must be divisible by cusps so every cusp is an exact sample");
    scale=_cg_cusp_scale(modul,tooth_number,cusps);
    points=_cg_cusp_points(scale,samples,cusps);
    _cg_assert_gear_inputs(points,modul,tooth_number,bore,pressure_angle,clearance);
    assert(is_2d || width>_cg_eps_len(),
        "stage=extrusion severity=error code=EXTRUSION_HEIGHT_INVALID message=width must be positive");
    rotate([0,0,orientation]) {
        state=_cg_cusp_state(modul,tooth_number,pressure_angle,backlash,clearance,samples,cusps);
        if(body_only) {
            outline=_cg_cusp_body_outline(state,tooth_number,cusps);
            assert(len(outline)>=3 && _cg_polyline_finite(outline) && !_cg_has_zero_edge(outline)
                && !_cg_has_immediate_backtrack(outline) && !_cg_has_duplicate_edge(outline)
                && _cg_polygon_area(outline)>_cg_eps_area(),
                "stage=polygon severity=error code=CUSP_BODY_TIP_OUTLINE_INVALID");
            assert(len(_cg_polygon_intersections(outline))==0,
                "stage=polygon severity=error code=CUSP_BODY_TIP_OUTLINE_SELF_INTERSECTION");
            if(is_2d)
                difference() {
                    if(body_offset==0) polygon(points=outline);
                    else offset(delta=body_offset) polygon(points=outline);
                    if(bore>0) circle(d=bore);
                }
            else
                linear_extrude(height=width,center=true,convexity=10)
                    difference() {
                        polygon(points=outline);
                        if(bore>0) circle(d=bore);
                    }
        } else {
            if(is_2d)
                _cg_gear_2d_from_pitch_points(state[0],modul,tooth_number,bore,pressure_angle,-90,true,backlash,clearance,false,state);
            else
                _cg_gear_from_state(state,modul,tooth_number,width,bore,pressure_angle,-90,true,backlash,clearance,false);
        }
    }
}

/***
 * @function curve_gear_cusp
 * @brief Build the hypocycloid cusp gear with regular radial teeth at its cusps.
 * Five cusps replace the canonical three-cusp deltoid. With 60 tooth positions, each cusp sector retains twelve tooth positions; the bore remains 4.8 mm. Set `cusps=5` and keep tooth count and samples divisible by five.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Tooth count; one radial tooth is centred on each cusp.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 720, divisible by cusps, default 720} Hypocycloid pitch-curve sampling density for validated cusp teeth.
 * @param orientation {angle, default 0} Whole-gear display rotation in degrees.
 * The common candidate validator accepts the full regular radial-root profile. Each cusp tooth is translated inward until its root width meets the local cusp-branch width; the cusp interval is then cropped and replaced by that unchanged tooth profile.
 * The mate is derived from the full placed driver outline and closed motion table.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 */
module curve_gear_cusp(modul,tooth_number,width,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,orientation=0,cusps=3) {
    _cg_cusp_build(modul,tooth_number,width,bore,pressure_angle,backlash,clearance,samples,orientation,false,cusps=cusps);
}

/***
 * @function curve_gear_cusp_body
 * @brief Build the hypocycloid body with its integrated cusp-tip teeth.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Tooth count scale.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param samples {integer >= 720, divisible by cusps, default 720} Pitch-curve sampling density for validated cusp geometry.
 * @param orientation {angle, default 0} Whole-body display rotation.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 */
module curve_gear_cusp_body(modul,tooth_number,width,bore,samples=720,orientation=0,cusps=3) {
    _cg_cusp_build(modul,tooth_number,width,bore,20,undef,undef,samples,orientation,true,cusps=cusps);
}

/***
 * @function curve_gear_cusp_2d
 * @brief Emit the complete cusp gear profile as 2D geometry.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Tooth count.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle, default 20} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 720, divisible by cusps} Hypocycloid curve sampling density.
 * @param orientation {angle, default 0} Whole-gear rotation in degrees.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @example c
 * curve_gear_cusp_2d(0.8, 36, 4.8);
 */
module curve_gear_cusp_2d(modul,tooth_number,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,orientation=0,cusps=3) {
    _cg_cusp_build(modul,tooth_number,0,bore,pressure_angle,backlash,clearance,samples,orientation,false,true,0,cusps);
}

/***
 * @function curve_gear_cusp_body_2d
 * @brief Emit the integrated-tip cusp body as 2D geometry with an optional inward offset.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by cusps} Tooth count.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param samples {integer >= 720, divisible by cusps} Hypocycloid curve sampling density.
 * @param orientation {angle, default 0} Whole-body rotation in degrees.
 * @param body_offset {number, default 0} Signed offset in mm; negative shrinks the outer contour and preserves the bore.
 * @param cusps {integer >= 3, default 3} Number of equally spaced hypocycloid cusps; tooth count and samples must be divisible by it.
 * @example c
 * curve_gear_cusp_body_2d(0.8, 36, 4.8, body_offset=-2);
 */
module curve_gear_cusp_body_2d(modul,tooth_number,bore,samples=720,orientation=0,body_offset=0,cusps=3) {
    _cg_cusp_build(modul,tooth_number,0,bore,20,undef,undef,samples,orientation,true,true,body_offset,cusps);
}
