// @regression: z-bounds -2 2
/***
 * @function cusp_meshed_pair_driver_bounds
 * @brief Verify the driver axial interval in a meshed Cusp pair.
 * Source: [`cusp/meshed_pair_driver_bounds.scad`](cusp/meshed_pair_driver_bounds.scad)
 */
include <../../src/cusp/pair.scad>
modul=1.2;
teeth=36;
width=4;
samples=720;
geometry=_cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples);
_cg_cusp_pair_member("driver",geometry,modul,teeth,width,0,20,0,undef,undef,true,360,.5,.08);
