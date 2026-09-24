/***
 * @function hypotrochoid_pair_pipeline
 * @brief Verify Hypotrochoid pair assembly and conjugate mate placement.
 * Source: [`hypotrochoid/pair_pipeline.scad`](hypotrochoid/pair_pipeline.scad)
 */
include <../../src/hypotrochoid/pair.scad>

$fn=96;
curve_gear_hypotrochoid_pair(.8,34,4,4.8,samples=240,phase=17,backlash=.02,clearance=.01);
