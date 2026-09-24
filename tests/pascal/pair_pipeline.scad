/***
 * @function pascal_pair_pipeline
 * @brief Verify Pascal pair assembly and conjugate mate placement.
 * Source: [`pascal/pair_pipeline.scad`](pascal/pair_pipeline.scad)
 */
include <../../src/pascal/pair.scad>

$fn=96;
curve_gear_pascal_pair(.8,34,4,4.8,eccentricity=.25,samples=120,phase=11,backlash=.02,clearance=.01);
translate([70,0,0])
    curve_gear_pascal_mate(.8,34,4,4.8,eccentricity=.25,samples=120,backlash=.02,clearance=.01);
