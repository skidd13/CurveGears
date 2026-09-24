/***
 * @function tooth_placement_validation_cases
 * @brief Deliberate local and boundary failures.  Each assertion confirms that the
 * Source: [`tooth/placement/validation_cases.scad`](tooth/placement/validation_cases.scad)
 *
 * expected diagnostic classification is produced rather than repaired away.
 *
 * The assertions are the test; the final OpenSCAD export is kept valid so the
 * fixture can still be rendered normally.
 */
include <../../../src/common/curve_gears_math.scad>

reversed_frame=[[0,0],[1,0],[0,1],1];
assert(_cg_frame_failure_code(reversed_frame)=="FRAME_NORMAL_REVERSED",
    "expected FRAME_NORMAL_REVERSED");
echo("stage=frame severity=info code=FRAME_NORMAL_REVERSED PASS");

crossing_left=[[0,0],[2,2],[4,0]];
crossing_right=[[0,0],[2,-2],[4,0]];
assert(_cg_has_flank_crossing(crossing_left,crossing_right),
    "expected FLANK_CROSSING");
echo("stage=flank severity=info code=FLANK_CROSSING PASS");

wide_backlash_candidate=_cg_reference_tooth_candidate(17,1,34,20,30);
assert(!wide_backlash_candidate[0] && wide_backlash_candidate[1]=="FLANK_ORDER_INVALID",
    "expected FLANK_ORDER_INVALID before top geometry");
echo("stage=flank severity=info code=FLANK_ORDER_INVALID PASS");

ambiguous_body=[[0,0],[4,0],[4,4],[0,4]];
ambiguous_tooth=[[-1,2],[5,2],[-1,2]];
ambiguous_hits=_cg_tooth_body_intersections(ambiguous_tooth,ambiguous_body);
assert(len(ambiguous_hits)>=3,"expected BODY_INTERSECTION_AMBIGUOUS");
echo("stage=intersection severity=info code=BODY_INTERSECTION_AMBIGUOUS PASS");

self_intersecting_body=[[0,0],[4,4],[0,4],[4,0]];
self_hits=_cg_polygon_intersections(self_intersecting_body);
assert(len(self_hits)>0,"expected POLYGON_SELF_INTERSECTION");
echo(str("stage=polygon severity=info code=POLYGON_SELF_INTERSECTION PASS segments=",self_hits[0][0],"/",self_hits[0][1]," point=",self_hits[0][2]));

overlap_a=[1,6,0,2];
overlap_b=[3,4,1,4];
assert(_cg_splice_relation(overlap_a,overlap_b)=="SPLICE_INTERVAL_OVERLAP",
    "expected SPLICE_INTERVAL_OVERLAP");
echo("stage=splice severity=info code=SPLICE_INTERVAL_OVERLAP PASS");

interleaved_a=[1,5,0,2];
interleaved_b=[3,7,1,4];
assert(_cg_splice_relation(interleaved_a,interleaved_b)=="SPLICE_INTERVAL_INTERLEAVED",
    "expected SPLICE_INTERVAL_INTERLEAVED");
echo("stage=splice severity=info code=SPLICE_INTERVAL_INTERLEAVED PASS");

function synthetic_placed(index,target,start_s,end_s) =
    ["placed","PASS",index,target,[],[],[],[],[[0,0],0,0,0,0,start_s],[[0,0],0,0,0,0,end_s],[],[]];
synthetic_overlap_failures=_cg_splice_failures([
    synthetic_placed(0,2,1,6),
    synthetic_placed(1,4,3,4)
],10);
assert(len(synthetic_overlap_failures)>0 && synthetic_overlap_failures[0][0]=="SPLICE_INTERVAL_OVERLAP",
    "expected splice validator to report SPLICE_INTERVAL_OVERLAP");
echo("stage=splice severity=info code=SPLICE_INTERVAL_OVERLAP_VALIDATOR PASS");

function synthetic_collision_placed(index,source,boundary) =
    ["placed","PASS",index,0, [source,[1,0],[0,1],1], [], boundary, [],
        [boundary[0],0,0,0,0,0], [boundary[len(boundary)-1],len(boundary)-1,0,0,0,1], [], []];
collision_a=synthetic_collision_placed(0,[0,0],[[-1,0],[1,0]]);
collision_b=synthetic_collision_placed(1,[.1,.1],[[0,-1],[0,1]]);
collision_hits=_cg_final_boundary_collisions([collision_a,collision_b],.8);
assert(len(collision_hits)>0 && collision_hits[0][0]=="TOOTH_COLLISION",
    "expected TOOTH_COLLISION from the source-point broad phase");
echo("stage=collision severity=info code=TOOTH_COLLISION_BROAD_PHASE PASS");

collision_unrelated=synthetic_collision_placed(9,[100,100],[[99,99],[101,101]]);
collision_with_unrelated=_cg_final_boundary_collisions([collision_a,collision_b,collision_unrelated],.8);
assert(len(collision_with_unrelated)>0 && collision_with_unrelated[0][1]==0 && collision_with_unrelated[0][2]==1,
    "expected the adjacent collision to survive an unrelated placement");
echo("stage=collision severity=info code=TOOTH_COLLISION_ADJACENT_WITH_UNRELATED PASS");

nonadjacent_collision=_cg_final_boundary_collisions([
    synthetic_collision_placed(0,[0,0],[[-1,0],[1,0]]),
    synthetic_collision_placed(2,[.1,.1],[[0,-1],[0,1]])
],.8);
assert(len(nonadjacent_collision)>0 && nonadjacent_collision[0][1]==0 && nonadjacent_collision[0][2]==2,
    "expected a non-adjacent collision");
echo("stage=collision severity=info code=TOOTH_COLLISION_NON_ADJACENT PASS");

collinear_hits=_cg_final_boundary_collisions([
    synthetic_collision_placed(0,[0,0],[[0,0],[2,0]]),
    synthetic_collision_placed(2,[.1,.1],[[1,0],[3,0]])
],.8);
assert(len(collinear_hits)>0 && collinear_hits[0][0]=="TOOTH_COLLISION",
    "expected collinear tooth overlap");
echo("stage=collision severity=info code=TOOTH_COLLISION_COLLINEAR PASS");

containment_hits=_cg_final_boundary_collisions([
    synthetic_collision_placed(0,[0,0],[[-2,-2],[2,-2],[2,2],[-2,2]]),
    synthetic_collision_placed(2,[.1,.1],[[-.5,-.5],[.5,-.5],[.5,.5],[-.5,.5]])
],.8);
assert(len(containment_hits)>0 && containment_hits[0][0]=="TOOTH_COLLISION",
    "expected contained tooth overlap");
echo("stage=collision severity=info code=TOOTH_COLLISION_CONTAINMENT PASS");

top_flank_hits=_cg_final_boundary_collisions([
    synthetic_collision_placed(0,[0,0],[[0,0],[2,2],[4,0],[0,0]]),
    synthetic_collision_placed(2,[.1,.1],[[1,0],[1,3],[3,3],[3,0]])
],.8);
assert(len(top_flank_hits)>0 && top_flank_hits[0][0]=="TOOTH_COLLISION",
    "expected top-to-flank collision");
echo("stage=collision severity=info code=TOOTH_COLLISION_TOP_FLANK PASS");

top_a=synthetic_collision_placed(0,[0,0],[[0,0],[-1,1],[1,1],[0,0]]);
top_b=synthetic_collision_placed(1,[.1,.1],[[0,0],[-1,1],[1,1],[0,0]]);
top_hits=_cg_final_boundary_collisions([top_a,top_b],.8);
top_overlap_hits=[for(hit=top_hits) if(hit[0]=="TOOTH_TOP_OVERLAP") hit];
assert(len(top_overlap_hits)>0,
    "expected TOOTH_TOP_OVERLAP from exact top-segment checking");
echo("stage=collision severity=info code=TOOTH_TOP_OVERLAP PASS");

order_failures=_cg_tooth_order_failures([top_b,top_a]);
assert(len(order_failures)>0 && order_failures[0][0]=="TOOTH_ORDER_CONFLICT",
    "expected TOOTH_ORDER_CONFLICT from reversed candidate order");
echo("stage=collision severity=info code=TOOTH_ORDER_CONFLICT PASS");

assert(abs(_cg_tooth_phase_fraction(90)-.25)<_cg_eps_len(),
    "expected degree tooth phase to map to one quarter contour turn");
echo("stage=placement severity=info code=TOOTH_PHASE_DEGREES PASS");

echo("PASS: deliberate tooth and boundary classifications");

cube([0.01,0.01,0.01]);
