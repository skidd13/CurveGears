/***
 * @function superformula_mate_pipeline
 * @brief Verify Bézier mate construction through the shared pair pipeline.
 * Source: [`superformula/mate_pipeline.scad`](superformula/mate_pipeline.scad)
 */
include <../../src/superformula/pair.scad>

$fn=96;
modul=.5;
tooth_number=80;
samples=360;
scale=_cg_superformula_scale(modul,tooth_number,5,1,1,.9,3.4,3.4,samples);
D=_cg_superformula_centre_distance(scale,5,1,1,.9,3.4,3.4);
motion=_cg_superformula_motion_table(scale,5,1,1,.9,3.4,3.4,D,samples);
mate=_cg_superformula_mate_points_from_driver(scale,5,1,1,.9,3.4,3.4,D,samples);
_cg_gear_from_pitch_points(mate,modul,tooth_number,4,4.8,20,0,false);
