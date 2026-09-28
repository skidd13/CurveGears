/**
 * @function cusp_pair_pipeline
 * @brief Render and validate the swept-envelope mate for a deltoid cusp driver.
 * Source: [`cusp/pair_pipeline.scad`](cusp/pair_pipeline.scad)
 */
include <../../src/cusp/pair.scad>

modul=1.2;
teeth=36;
samples=720;
sweep_steps=360;
geometry=_cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples);
driver_state=geometry[0];
driver_outline=_cg_cusp_envelope_driver_outline(driver_state);
motion=geometry[4][2];
invalid_driver_placements=len([for(p=driver_state[5]) if(p[0]=="invalid") 1]);
omitted_driver_placements=len([for(p=driver_state[5]) if(p[0]!="placed") 1]);
envelope_poses=_cg_mate_sweep_pose_count(motion,sweep_steps,.5);
echo(str("cusp envelope distance=",geometry[3]," closure_error=",_cg_motion_closure_error(motion),
    " driver placed=",len([for(p=driver_state[5]) if(p[0]=="placed") 1]),
    " omitted=",omitted_driver_placements," invalid=",invalid_driver_placements,
    " envelope poses=",envelope_poses));
assert(_cg_mate_envelope_motion_valid(motion),"cusp envelope motion must be finite, monotone and closed");
assert(invalid_driver_placements==0,"the driver common tooth pipeline must reject no candidate as invalid");
assert(len(driver_outline)>=3 && len(_cg_polygon_intersections(driver_outline))==0,
    "the complete accepted driver outline must be a simple polygon");
assert(envelope_poses>=sweep_steps,"adaptive envelope sampling must include every base motion interval");
curve_gear_cusp_pair(modul,teeth,4,0,samples=samples,sweep_steps=sweep_steps,phase=0,together_built=true);
