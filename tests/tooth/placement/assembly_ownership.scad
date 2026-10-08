/***
 * @function tooth_placement_assembly_ownership
 * @brief Preserve missing and duplicate tooth detection using exposed tops as root unions hide internal splice points.
 * Source: [`tooth/placement/assembly_ownership.scad`](tooth/placement/assembly_ownership.scad)
 */
include <../../../src/circle/base.scad>
state=_cg_tooth_geometry_state(_cg_circle_points(.8,34,120),.8,34,20,0,false,undef,undef,false,true);
outline=state[7];placements=state[5];
witness=placements[7][6][len(placements[7][5][4])-1];
missing=[for(point=outline) if(_cg_vlen(point-witness)>_cg_eps_len()) point];
duplicate=concat([witness],outline);
assert(len(_cg_assembled_component_failures(outline,placements,state[12]))==0);
assert(len([for(f=_cg_assembled_component_failures(missing,placements,state[12])) if(f[0]=="MERGE_MISSING_TOOTH" && f[1]==7) 1])==1);
assert(len([for(f=_cg_assembled_component_failures(duplicate,placements,state[12])) if(f[0]=="MERGE_DUPLICATE_TOOTH" && f[1]==7) 1])==1);
echo("PASS: missing and duplicate exposed tooth ownership remain enforced");
cube(.01);
