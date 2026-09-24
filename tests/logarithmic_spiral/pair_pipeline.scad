/***
 * @function logarithmic_spiral_pair_pipeline
 * @brief Verify Logarithmic spiral pair assembly and conjugate mate placement.
 * Source: [`logarithmic_spiral/pair_pipeline.scad`](logarithmic_spiral/pair_pipeline.scad)
 */
include <../../src/logarithmic_spiral/pair.scad>

$fn=96;
curve_gear_logarithmic_spiral_pair(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120,assembly_clearance=.1,backlash=.02,clearance=.01);
translate([70,0,0])
    curve_gear_logarithmic_spiral_mate(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120,backlash=.02,clearance=.01);
