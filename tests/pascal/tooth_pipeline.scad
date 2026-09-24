/***
 * @function pascal_tooth_pipeline
 * @brief Verify Pascal tooth placement through the shared tooth pipeline.
 * Source: [`pascal/tooth_pipeline.scad`](pascal/tooth_pipeline.scad)
 */
include <../../src/pascal/gear.scad>

$fn=96;
curve_gear_pascal(.8,34,4,4.8,eccentricity=.68,samples=360);
