/***
 * @function superformula_pair_pipeline
 * @brief Verify Superformula pair assembly and conjugate mate placement.
 * Source: [`superformula/pair_pipeline.scad`](superformula/pair_pipeline.scad)
 */
include <../../src/superformula/pair.scad>

$fn=96;
curve_gear_superformula_pair(.8,34,4,4.8,symmetry=5,n1=2.4,n2=3.4,n3=3.4);
translate([70,0,0])
    curve_gear_superformula_mate(.8,34,4,4.8,symmetry=5,n1=2.4,n2=3.4,n3=3.4,samples=360,backlash=.02,clearance=.01);
