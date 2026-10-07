/***
 * @function cusp_parameter_pipeline
 * @brief Validate hypocycloid cusp counts, exact cusp anchors and five-cusp gear/body geometry.
 * Source: [`cusp/parameter_pipeline.scad`](cusp/parameter_pipeline.scad)
 */
include <../../src/cusp/pair.scad>

// Independent analytic witnesses: cusp positions, sector symmetry and perimeter.
for(n=[3,4,5,6,8]) {
    z=12*n;
    a=_cg_cusp_scale(.8,z,n);
    points=_cg_cusp_points(a,720,n);
    expected_perimeter=.8*z*_cg_circle_pi;
    assert(abs(8*a*(n-1)-expected_perimeter)<1e-9,"hypocycloid scale must preserve circular tooth pitch");
    assert(abs(_cg_polyline_arc_table(points)[720][1]-expected_perimeter)<.02,
        "sampled perimeter must approximate the analytic hypocycloid perimeter");
    for(k=[0:n-1]) {
        expected=[n*a*cos(360*k/n),n*a*sin(360*k/n)];
        assert(_cg_vlen(_cg_vsub(points[k*720/n],expected))<1e-9,"every cusp must be an exact pitch sample");
        assert(_cg_cusp_indices(z,n)[k]==k*12,"each cusp must align with its tooth index");
    }
}

modul=.8; teeth=60; cusps=5; samples=720;
state=_cg_cusp_state(modul,teeth,20,undef,undef,samples,cusps);
assert(_cg_tooth_geometry_state_valid(state),"five-cusp driver must pass all shared geometry checks");
// As in the default Cusp, ordinary teeth immediately beside singular tips
// can be inaccessible. This fixture must omit exactly those ten positions.
expected_omissions=[for(i=[0:teeth-1]) if(i%12==1 || i%12==11) i];
omissions=[for(p=state[5]) if(p[0]!="placed") p[2]];
assert(omissions==expected_omissions && len([for(p=state[5]) if(p[0]=="invalid") 1])==0,
    "five-cusp omissions must be limited to the two inaccessible positions beside each cusp");
reference=_cg_reference_tooth_candidate(modul*teeth/2,modul,teeth,20,undef,undef,true);
for(i=_cg_cusp_indices(teeth,cusps)) {
    p=state[5][i];
    assert(p[1]=="CUSP_CURVE_ANCHOR","each cusp must use a radial cusp anchor");
    assert(p[5][8]==reference[8],"cusp teeth must preserve the complete standard tooth profile");
    assert(_cg_vlen(_cg_vsub(p[4][2],[cos(360*i/teeth),sin(360*i/teeth)]))<1e-9,
        "cusp normals must use the exact analytic cusp axes");
}
geometry=_cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples,cusps);
assert(_cg_mate_envelope_motion_valid(geometry[4][2]),"five-cusp mate motion must close and remain monotone");
assert(abs(curve_gear_cusp_centre_distance(modul,teeth,cusps=cusps)-geometry[3])<1e-9,
    "public centre-distance helper must propagate cusp count");
assert(abs(curve_gear_cusp_mate_rotation(modul,teeth,phase=360,cusps=cusps)
    -curve_gear_cusp_mate_rotation(modul,teeth,phase=0,cusps=cusps)+360)<.08,
    "public mate rotation must complete one opposite turn");
translate([-30,0,0]) curve_gear_cusp(modul,teeth,4,4.8,cusps=cusps);
translate([30,0,0]) curve_gear_cusp_body(modul,teeth,4,4.8,cusps=cusps);
