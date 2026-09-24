/***
 * @function lobed_tooth_pipeline
 * @brief Verify Lobed tooth placement through the shared tooth pipeline.
 * Source: [`lobed/tooth_pipeline.scad`](lobed/tooth_pipeline.scad)
 */
include <../../src/lobed/gear.scad>

$fn=96;
curve_gear_lobed(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=120);
