/***
 * @function epitrochoid_pair_pipeline
 * @brief Verify Epitrochoid pair assembly and conjugate mate placement.
 * Source: [`epitrochoid/pair_pipeline.scad`](epitrochoid/pair_pipeline.scad)
 */
include <../../src/epitrochoid/pair.scad>

$fn=96;
curve_gear_epitrochoid_pair(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120,phase=19,backlash=.02,clearance=.01);
translate([70,0,0])
    curve_gear_epitrochoid_mate(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120,backlash=.02,clearance=.01);
