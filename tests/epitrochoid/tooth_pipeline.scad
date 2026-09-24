/***
 * @function epitrochoid_tooth_pipeline
 * @brief Verify Epitrochoid tooth placement through the shared tooth pipeline.
 * Source: [`epitrochoid/tooth_pipeline.scad`](epitrochoid/tooth_pipeline.scad)
 */
include <../../src/epitrochoid/gear.scad>

$fn=96;
curve_gear_epitrochoid(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120);
