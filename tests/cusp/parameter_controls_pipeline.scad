/***
 * @function cusp_parameter_controls_pipeline
 * @brief Validate independent tooth counts, module and extrusion widths for four, five and six cusps.
 * Source: [`cusp/parameter_controls_pipeline.scad`](cusp/parameter_controls_pipeline.scad)
 */
include <../../src/cusp/gear.scad>

variants=[[4,48,.8,2],[5,40,.6,3],[5,80,1,6],[6,72,.8,2]];
for(k=[0:len(variants)-1]) {
    v=variants[k]; cusps=v[0]; teeth=v[1]; modul=v[2]; width=v[3];
    state=_cg_cusp_state(modul,teeth,20,undef,undef,720,cusps);
    assert(_cg_tooth_geometry_state_valid(state),"adjustable cusp/tooth/module combination must pass all geometry checks");
    assert(len(_cg_splice_failures(state[5],state[2]))==0,"cusp and ordinary teeth must own disjoint splice intervals");
    for(i=_cg_cusp_indices(teeth,cusps))
        assert(state[5][i][0]=="placed","changing tooth density must preserve every cusp-tip tooth");
    translate([100*k,0,0]) curve_gear_cusp(modul,teeth,width,4.8,cusps=cusps);
}
