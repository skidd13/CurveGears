/***
 * @function tooth_generation_segment_bounds_equivalence
 * @brief Prove ordered broad-phase and exact validation equivalence for crossing, duplicate and near-tolerance polygons.
 * Source: [`tooth/generation/segment_bounds_equivalence.scad`](tooth/generation/segment_bounds_equivalence.scad)
 */
include <../../../src/common/curve_gears_math.scad>
polygons=[
    [[0,0],[4,4],[0,4],[4,0]],
    [[0,0],[3,0],[3,3],[0,3],[0,0],[3,0],[3,-2],[0,-2]],
    [[0,0],[1,0],[1,0],[1,1],[0,1]],
    [[0,0],[1,0],[2,0],[3,0]],
    [[0,0],[10,0],[10,10],[0,10],[0,1e-8],[10,1e-8],[10,9],[0,9]],
    [for(i=[0:127]) [10*cos(360*i/128),10*sin(360*i/128)]],
    [for(i=[0:127]) let(t=360*i/128,r=10*(1+.35*cos(5*t))) [r*cos(t),r*sin(t)]],
    [for(i=[0:63]) let(t=360*((i*27)%64)/64) [10*cos(t),10*sin(t)]]
];
queries=[[[0,-12],[0,12],[.1,12]],[[9.99999999,-1],[10.00000001,1],[11,0]],[[20,20],[21,20],[20,21]]];
for(k=[0:len(polygons)-1]) {
    p=polygons[k];
    assert(_cg_polygon_intersections(p)==_cg_polygon_intersections_direct(p),str("ordered polygon hits differ: case=",k));
    assert(_cg_has_duplicate_edge(p)==_cg_has_duplicate_edge_direct(p),str("duplicate-edge result differs: case=",k));
    for(q=queries)
        assert(_cg_tooth_body_intersections(q,p)==_cg_tooth_body_intersections_direct(q,p),
            str("ordered boundary hits differ: case=",k));
}
// Every accepted pair in the reference broad phase must be returned in order.
for(p=polygons) {
    tree=_cg_segment_bounds_tree(p);
    for(i=[0:len(p)-1]) {
        reference=[for(j=[0:len(p)-1])
            if(_cg_bbox_segments_overlap(p[i],p[(i+1)%len(p)],p[j],p[(j+1)%len(p)])) j];
        assert(_cg_segment_bounds_candidates(tree,p[i],p[(i+1)%len(p)])==reference,"broad-phase leaf candidates/order differ");
    }
}
echo("PASS: exact candidate, crossing, duplicate and boundary records for eight adversarial polygons");
cube(.01);
