/**
 * @function tanh_triad_full_pipeline
 * @brief Verify the complete Tanh Triad gear, mate and pair entry points.
 * Source: [`tanh_triad/full_pipeline.scad`](tanh_triad/full_pipeline.scad)
 */
include <../../src/tanh_triad/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_tanh_triad(.8,34,4,4.8,samples=120);
translate([-35,0,0]) curve_gear_tanh_triad_body(.8,34,4,4.8,samples=120);
translate([35,0,0]) curve_gear_tanh_triad_mate(.8,34,4,4.8,samples=120);
translate([100,0,0]) curve_gear_tanh_triad_pair(.8,34,4,4.8,samples=120);
