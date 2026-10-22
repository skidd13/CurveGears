// @regression: z-bounds -2 2
/***
 * @function cusp_separated_pair_driver_bounds
 * @brief Verify the driver axial interval in a separated Cusp pair.
 * Source: [`cusp/separated_pair_driver_bounds.scad`](cusp/separated_pair_driver_bounds.scad)
 */
include <../../src/cusp/pair.scad>
modul=1.2;
teeth=36;
width=4;
samples=720;
geometry=_cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples);
_cg_cusp_pair_member("driver",geometry,modul,teeth,width,0,20,0,undef,undef,false,360,.5,.08);
