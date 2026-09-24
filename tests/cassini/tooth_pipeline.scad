/***
 * @function cassini_tooth_pipeline
 * @brief Verify Cassini tooth placement through the shared tooth pipeline.
 * Source: [`cassini/tooth_pipeline.scad`](cassini/tooth_pipeline.scad)
 */
include <../../src/cassini/gear.scad>

$fn=96;
curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=240);
