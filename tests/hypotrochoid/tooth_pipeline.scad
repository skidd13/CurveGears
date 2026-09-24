/***
 * @function hypotrochoid_tooth_pipeline
 * @brief Verify Hypotrochoid tooth placement through the shared tooth pipeline.
 * Source: [`hypotrochoid/tooth_pipeline.scad`](hypotrochoid/tooth_pipeline.scad)
 */
include <../../src/hypotrochoid/gear.scad>

$fn=96;
curve_gear_hypotrochoid(.8,34,4,4.8,samples=240);
