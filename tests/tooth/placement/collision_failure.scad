/***
 * @function tooth_placement_collision_failure
 * @brief Expected-failure gate for a complete placed-tooth collision.
 * Source: [`tooth/placement/collision_failure.scad`](tooth/placement/collision_failure.scad)
 */
include <../../../src/common/curve_gears_math.scad>

function synthetic_placed(index,source,boundary) =
    ["placed","PASS",index,0,[source,[1,0],[0,1],1],[],boundary,[],
        [boundary[0],0,0,0,0,0],
        [boundary[len(boundary)-1],len(boundary)-1,0,0,0,1],[],[]];

a=synthetic_placed(0,[0,0],[[-1,0],[1,0]]);
b=synthetic_placed(1,[.1,.1],[[0,-1],[0,1]]);
hits=_cg_final_boundary_collisions([a,b],.8);
assert(len(hits)==0,
    str("stage=collision severity=error code=TOOTH_COLLISION message=synthetic complete candidate collision",
        " pair=",hits[0][1],"/",hits[0][2]," segments=",hits[0][3][0],"/",hits[0][3][1],
        " point=",hits[0][3][2]," eps_intersect=",_cg_eps_intersect()));

cube([0.01,0.01,0.01]);
