/***
 * @function superformula_tooth_pipeline
 * @brief Verify Superformula tooth placement through the shared tooth pipeline.
 * Source: [`superformula/tooth_pipeline.scad`](superformula/tooth_pipeline.scad)
 */
include <../../src/superformula/gear.scad>

$fn=96;
curve_gear_superformula(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=360);
