/***
 * @function epitrochoid_full_pipeline
 * @brief Verify the complete Epitrochoid gear, mate, and pair entry points.
 * Source: [`epitrochoid/full_pipeline.scad`](epitrochoid/full_pipeline.scad)
 */
include <../../src/epitrochoid/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_epitrochoid(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120);
translate([-35,0,0]) curve_gear_epitrochoid_body(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120);
translate([35,0,0]) curve_gear_epitrochoid_mate(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120);
translate([100,0,0]) curve_gear_epitrochoid_pair(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=120);
