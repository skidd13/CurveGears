/***
 * @function lobed_pair_pipeline
 * @brief Verify Lobed pair assembly and conjugate mate placement.
 * Source: [`lobed/pair_pipeline.scad`](lobed/pair_pipeline.scad)
 */
include <../../src/lobed/pair.scad>

$fn=96;
curve_gear_lobed_pair(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120,phase=-13,backlash=.02,clearance=.01);
translate([70,0,0])
    curve_gear_lobed_mate(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120,backlash=.02,clearance=.01);
