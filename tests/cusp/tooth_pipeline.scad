/**
 * @function cusp_tooth_pipeline
 * @brief Assert the cusp tip uses a validated, bounded regular-tooth profile.
 * Source: [`cusp/tooth_pipeline.scad`](cusp/tooth_pipeline.scad)
 */
include <../../src/cusp/gear.scad>

modul=1.2; teeth=36; samples=720;
state=_cg_cusp_state(modul,teeth,20,undef,undef,samples);
cusps=_cg_cusp_indices(teeth);
normal=_cg_reference_tooth_candidate(modul*teeth/2,modul,teeth,20,undef,undef,true);
tip=state[5][cusps[0]][5];
anchor=state[5][cusps[0]];
root_gap=max(_cg_vlen(_cg_vsub(anchor[6][1],anchor[8][0])),
    _cg_vlen(_cg_vsub(anchor[6][len(anchor[6])-2],anchor[9][0])));
visible_tip_height=max([for(p=tip[8]) p[0]])-tip[8][1][0];
body_outline=_cg_cusp_body_outline(state,teeth);
arch_sample=_cg_cusp_body_branch_point(_cg_cusp_scale(modul,teeth),300,_cg_dedendum(modul));
arch_sample_error=min([for(p=body_outline) _cg_vlen(_cg_vsub(p,arch_sample))]);
analytic_cusp_frames=[for(i=cusps)
    let(
        placement=state[5][i],frame=placement[4],angle=360*i/teeth,
        expected_tangent=[-sin(angle),cos(angle)],
        expected_normal=[cos(angle),sin(angle)],
        expected_radius=3*_cg_cusp_scale(modul,teeth)-placement[5][11][1],
        expected_origin=_cg_polar([expected_radius,angle])
    )
    _cg_vlen(_cg_vsub(frame[0],expected_origin))<1e-6
        && _cg_vlen(_cg_vsub(frame[1],expected_tangent))<1e-9
        && _cg_vlen(_cg_vsub(frame[2],expected_normal))<1e-9 ? 1 : 0];
echo(str("cusp curve anchors: ",[for(i=cusps) [state[5][i][0],state[5][i][1],len(state[5][i][7])]]));
echo(str("cusp normal tooth top width: ",tip[2]," visible flank-root to tip height: ",visible_tip_height," mm"));
echo(str("cusp tooth-root to cropped-body endpoint gap: ",root_gap," mm"));
assert(state[4][0] && min([for(i=cusps) state[5][i][0]=="placed" ? 1 : 0])==1,
    "the three cusp-tip curve segments must be installed as anchors");
assert(min(analytic_cusp_frames)==1,
    "each cusp tooth must use the exact radial frame of its analytic cusp axis");
assert(abs(tip[2]-normal[2])<1e-6
    && abs(visible_tip_height-(_cg_dedendum(modul)+_cg_addendum(modul)))<.1*modul,
    "the cusp crop must expose one normal-height tooth above its flank-root shoulders");
assert(tip[0] && max([for(i=[0:len(tip[4])-1]) _cg_vlen(_cg_vsub(tip[4][i],normal[4][i]))])<1e-6,
    "the cusp tip must retain the 1:1 validated normal-tooth flanks");
assert(anchor[8][1]==0 && anchor[8][3]==1
    && anchor[9][1]==len(anchor[6])-3 && anchor[9][3]==1 && root_gap<.03,
    "the recessed regular tooth roots must meet the cusp body at both crop shoulders");
assert(arch_sample_error<.4,
    "the body outline must retain the curved lower-right deltoid branch between cusp teeth");
assert(len(state[6])==0 && len(state[8])==0 && len(state[9])==0 && len(state[10])==0,
    "cusp body, nearby tooth, assembly, and final polygon validation must pass");
assert(_cg_tooth_geometry_state_valid(state),"the cusp mate must reuse the common complete tooth-state validation");
_cg_gear_from_state(state,modul,teeth,4,0,20,-90,true);
