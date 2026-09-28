/**
 * @function cusp_full_pipeline
 * @brief Render the cusp gear, body, swept-envelope mate, and separated pair.
 * Source: [`cusp/full_pipeline.scad`](cusp/full_pipeline.scad)
 */
include <../../src/cusp/gear.scad>
include <../../src/cusp/mate.scad>
include <../../src/cusp/pair.scad>

modul=1.2;
teeth=36;
samples=720;
geometry=_cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples);
driver_radii=geometry[1]; distance=geometry[3]; motion=geometry[4][2];
echo(str("cusp envelope motion closure error: ",_cg_motion_closure_error(motion),
    "; driver radius range: ",[min(driver_radii),max(driver_radii)],"; mate blank radius: ",_cg_cusp_envelope_mate_outer_radius(geometry,modul)));
translate([-70,0,0]) curve_gear_cusp(modul,teeth,4,0,samples=samples);
translate([-20,0,0]) curve_gear_cusp_body(modul,teeth,4,0,samples=samples);
translate([20,0,0]) curve_gear_cusp_mate(modul,teeth,4,0,samples=samples);
translate([75,0,0]) curve_gear_cusp_pair(modul,teeth,4,0,samples=samples,together_built=false);
