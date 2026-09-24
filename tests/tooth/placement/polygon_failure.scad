/***
 * @function tooth_placement_polygon_failure
 * @brief Expected-failure gate for the final polygon self-intersection validator.
 * Source: [`tooth/placement/polygon_failure.scad`](tooth/placement/polygon_failure.scad)
 */
include <../../../src/common/curve_gears_math.scad>

outline=[[0,0],[4,4],[0,4],[4,0]];
hits=_cg_polygon_intersections(outline);
first_hit=len(hits)>0 ? hits[0] : [0,0,[0,0]];
assert(len(hits)==0,
    str("stage=polygon severity=error code=POLYGON_SELF_INTERSECTION message=synthetic final boundary crossing",
        " segment=",first_hit[0],"/",first_hit[1]," point=",first_hit[2],
        " eps_intersect=",_cg_eps_intersect()));

cube([0.01,0.01,0.01]);
