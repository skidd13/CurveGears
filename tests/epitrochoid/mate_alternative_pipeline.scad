/***
 * @function epitrochoid_mate_alternative_pipeline
 * @brief Fully render the stronger alternative mate with the corrected physical-radius pitch law and canonical bore.
 * Source: [`epitrochoid/mate_alternative_pipeline.scad`](epitrochoid/mate_alternative_pipeline.scad)
 */
include <../../src/epitrochoid/mate.scad>
$fn=96;
curve_gear_epitrochoid_mate(.7,48,3,4.8,major_ratio=2,rolling_ratio=1,offset_ratio=.65,samples=360);
