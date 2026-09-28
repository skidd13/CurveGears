/***
 * @module Cusp
 * @brief Build the three-cusp deltoid gear and its radial-root body.
 */
include <base.scad>

function _cg_cusp_indices(tooth_number) = [0,tooth_number/3,2*tooth_number/3];
function _cg_cusp_body_branch_point(a,t,dedendum) =
    let(x=a*(2*cos(t)+cos(2*t)),y=a*(2*sin(t)-sin(2*t)),radius=_cg_vlen([x,y]),root=max(radius-dedendum,.02*dedendum))
        [x*root/radius,y*root/radius];
function _cg_cusp_parameter_for_body_y(a,target,dedendum,lo=0,hi=60,i=0) =
    i>=32 ? (lo+hi)/2 :
    let(mid=(lo+hi)/2)
        _cg_cusp_body_branch_point(a,mid,dedendum)[1]>target
            ? _cg_cusp_parameter_for_body_y(a,target,dedendum,lo,mid,i+1)
            : _cg_cusp_parameter_for_body_y(a,target,dedendum,mid,hi,i+1);
function _cg_cusp_tip_candidate(modul,tooth_number,pressure_angle,backlash,clearance) =
    let(
        a=_cg_cusp_scale(modul,tooth_number),pitch_radius=modul*tooth_number/2,
        standard=_cg_reference_tooth_candidate(pitch_radius,modul,tooth_number,pressure_angle,backlash,clearance,true),
        reference=_cg_reference_tooth_local_flanks(pitch_radius,modul,tooth_number,pressure_angle,backlash,clearance,true),
        half_width=_cg_vlen(_cg_vsub(reference[1][0],reference[0][0]))/2,
        dedendum=_cg_dedendum(modul,clearance),
        t=_cg_cusp_parameter_for_body_y(a,half_width,dedendum),
        branch_arc=(8*a/3)*(1-cos(1.5*t)),
        body_root=_cg_cusp_body_branch_point(a,t,dedendum),
        inset=3*a+standard[4][1][0]-pitch_radius-body_root[0],
        height=_cg_addendum(modul),candidate=standard
    )
    concat(candidate,[[t,inset,branch_arc,"driver_cusp",height,[0,0],[0,0]]]);

function _cg_cusp_anchor_placement(points,arc,perimeter,body,modul,tooth_number,index,candidate,phase=-90) =
    let(target=perimeter*(index+.25+phase/360)/tooth_number,source_frame=_cg_local_frame_for_closed_arc(points,arc,perimeter,target),
        frame=[_cg_vsub(source_frame[0],[source_frame[2][0]*candidate[11][1],source_frame[2][1]*candidate[11][1]]),source_frame[1],source_frame[2],source_frame[3]],
        branch_arc=candidate[11][2],boundary=[for(p=candidate[8]) _cg_profile_point_at_frame(p,frame[0],frame[2],frame[1],modul*tooth_number/2)],
        left_s=target-branch_arc,right_s=target+branch_arc,
        left=[_cg_point_for_closed_arc(body,arc,left_s),0,_cg_arc_segment_index(arc,perimeter,left_s),1,0,left_s],
        right=[_cg_point_for_closed_arc(body,arc,right_s),len(boundary)-3,_cg_arc_segment_index(arc,perimeter,right_s),1,0,right_s])
    ["placed","CUSP_CURVE_ANCHOR",index,target,frame,candidate,boundary,[left,right],left,right,[false,-1,[0,0],0,0,frame,[]],[]];

function _cg_cusp_prepared_state(points,modul,tooth_number,pressure_angle,backlash,clearance,tip_candidate,phase=-90) =
    let(
        arc=_cg_polyline_arc_table(points),perimeter=arc[len(arc)-1][1],
        body=_cg_canonical_body_polyline(points,arc,perimeter,_cg_dedendum(modul,clearance),true),
        cusps=_cg_cusp_indices(tooth_number),
        standard=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,pressure_angle,backlash,clearance,true),
        ordinary=[for(i=[0:tooth_number-1]) if(len([for(c=cusps) if(c==i) 1])==0)
            let(target=perimeter*(i+.25+phase/360)/tooth_number)
                _cg_placement_result(points,arc,perimeter,body,modul,tooth_number,i,standard,pressure_angle,phase,true,backlash,clearance)],
        cusp_placements=[for(i=cusps)
            _cg_cusp_anchor_placement(points,arc,perimeter,body,modul,tooth_number,i,tip_candidate,phase)],
        evaluated=concat(ordinary,cusp_placements),
        placements=[for(i=[0:tooth_number-1]) [for(p=evaluated) if(p[2]==i) p][0]]
    )
    _cg_tooth_geometry_state(points,modul,tooth_number,pressure_angle,phase,true,backlash,clearance,false,true,[standard,placements]);

function _cg_cusp_body_outline(state,tooth_number) =
    let(cusps=_cg_cusp_indices(tooth_number),tip_placements=[for(p=state[5]) if(len([for(i=cusps) if(p[2]==i) 1])>0) p])
    _cg_final_outline_from_placements(state[3],state[1],state[2],tip_placements);
function _cg_cusp_state(modul,tooth_number,pressure_angle=20,backlash=undef,clearance=undef,samples=720) =
    let(
        scale=_cg_cusp_scale(modul,tooth_number),points=_cg_cusp_points(scale,samples),
        candidate=_cg_cusp_tip_candidate(modul,tooth_number,pressure_angle,backlash,clearance)
    )
        _cg_cusp_prepared_state(points,modul,tooth_number,pressure_angle,backlash,clearance,candidate);

function _cg_cusp_cross2(a,b) = a[0]*b[1]-a[1]*b[0];
function _cg_cusp_ray_segment_radius(a,b,angle) =
    let(direction=[cos(angle),sin(angle)],segment=_cg_vsub(b,a),denominator=_cg_cusp_cross2(direction,segment),
        u=abs(denominator)<=_cg_eps_len() ? -1 : _cg_cusp_cross2(a,direction)/denominator,
        radius=abs(denominator)<=_cg_eps_len() ? -1 : _cg_cusp_cross2(a,segment)/denominator)
    abs(denominator)>_cg_eps_len() && u>=-_cg_eps_len() && u<=1+_cg_eps_len() && radius>=0 ? radius : 0;
function _cg_cusp_radius_on_outline(outline,angle) =
    max([for(i=[0:len(outline)-1]) _cg_cusp_ray_segment_radius(outline[i],outline[(i+1)%len(outline)],angle)]);
function _cg_cusp_threefold_radii(outline,samples,midpoint,pitch_offset) =
    let(count=samples/3,sector=[for(i=[0:count-1])
        _cg_cusp_radius_on_outline(outline,360*(i+(midpoint ? .5 : 0))/samples)+pitch_offset])
    concat(sector,sector,sector);
function _cg_cusp_pair_motion_geometry(modul,tooth_number,pressure_angle,backlash,clearance,samples) =
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number && tooth_number%3==0,
        "cusp_gear: tooth_number must be an integer divisible by 3")
    assert(samples>=120 && floor(samples)==samples && samples%3==0,
        "cusp_gear: samples must be an integer >= 120 and divisible by 3")
    let(
        scale=_cg_cusp_scale(modul,tooth_number),driver_state=_cg_cusp_state(modul,tooth_number,pressure_angle,backlash,clearance,samples),
        // The rolling law uses the unmodified deltoid pitch curve; the tooth
        // outline is passed separately to the swept-envelope mate builder.
        pitch_curve=_cg_cusp_points(scale,samples),
        driver_radii=_cg_cusp_threefold_radii(pitch_curve,samples,false,0),
        mid_radii=_cg_cusp_threefold_radii(pitch_curve,samples,true,0),
        maximum=max(driver_radii),distance=_cg_solve_mate_distance(mid_radii,maximum+.01,7*scale),
        integration=_cg_motion_integration_state(driver_radii,mid_radii,distance)
    )
    [driver_state,driver_radii,mid_radii,distance,integration];

module _cg_cusp_build(modul,tooth_number,width,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false) {
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number && tooth_number%3==0,
        "cusp_gear: tooth_number must be an integer divisible by 3 so each cusp aligns with a tooth");
    _cg_assert_samples(samples,"cusp_gear: samples must be an integer >= 720 for the validated cusp teeth",720);
    assert(samples%3==0,"cusp_gear: samples must be divisible by 3 so every cusp is an exact sample");
    scale=_cg_cusp_scale(modul,tooth_number);
    points=_cg_cusp_points(scale,samples);
    rotate([0,0,orientation]) {
        state=_cg_cusp_state(modul,tooth_number,pressure_angle,backlash,clearance,samples);
        if(body_only) {
            outline=_cg_cusp_body_outline(state,tooth_number);
            assert(len(outline)>=3 && _cg_polyline_finite(outline) && !_cg_has_zero_edge(outline)
                && !_cg_has_immediate_backtrack(outline) && !_cg_has_duplicate_edge(outline)
                && _cg_polygon_area(outline)>_cg_eps_area(),
                "stage=polygon severity=error code=CUSP_BODY_TIP_OUTLINE_INVALID");
            assert(len(_cg_polygon_intersections(outline))==0,
                "stage=polygon severity=error code=CUSP_BODY_TIP_OUTLINE_SELF_INTERSECTION");
            linear_extrude(height=width,center=true,convexity=10)
                difference() {
                    polygon(points=outline);
                    if(bore>0) circle(d=bore);
                }
        } else {
            _cg_gear_from_state(state,modul,tooth_number,width,bore,pressure_angle,-90,true,backlash,clearance,false);
        }
    }
}

/***
 * @function curve_gear_cusp(modul, tooth_number, width, bore, ...)
 * @brief Build the three-cusp deltoid gear with regular radial teeth at its cusps.
 * @image ../images/functions/cusp/curve_gear_cusp.png Cusp gear preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by 3} Tooth count; one radial tooth is centred on each cusp.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Standard-flank pressure angle.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 720, divisible by 3, default 720} Deltoid pitch-curve sampling density for validated cusp teeth.
 * @param orientation {angle, default 0} Whole-gear display rotation in degrees.
 * The common candidate validator accepts the full regular radial-root profile. Each cusp tooth is translated inward until its root width meets the local cusp-branch width; the cusp interval is then cropped and replaced by that unchanged tooth profile.
 * The mate is derived from the full placed driver outline and closed motion table.
 */
module curve_gear_cusp(modul,tooth_number,width,bore,pressure_angle=20,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cusp_build(modul,tooth_number,width,bore,pressure_angle,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_cusp_body(modul, tooth_number, width, bore, ...)
 * @brief Build the three-cusp deltoid body with its integrated cusp-tip teeth.
 * @image ../images/functions/cusp/curve_gear_cusp_body.png Cusp gear body preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3, divisible by 3} Tooth count scale.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param samples {integer >= 720, divisible by 3, default 720} Pitch-curve sampling density for validated cusp geometry.
 * @param orientation {angle, default 0} Whole-body display rotation.
 */
module curve_gear_cusp_body(modul,tooth_number,width,bore,samples=720,orientation=0) {
    _cg_cusp_build(modul,tooth_number,width,bore,20,undef,undef,samples,orientation,true);
}
