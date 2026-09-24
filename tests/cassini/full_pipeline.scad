/***
 * @function cassini_full_pipeline
 * @brief Verify the complete Cassini gear, mate, and pair entry points.
 * Source: [`cassini/full_pipeline.scad`](cassini/full_pipeline.scad)
 */
include <../../src/cassini/gear.scad>
include <../../src/cassini/mate.scad>
include <../../src/cassini/pair.scad>

$fn=96;
translate([-110,0,0]) curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=240);
translate([-35,0,0]) curve_gear_cassini_body(.8,34,4,4.8,focus_ratio=.78,samples=240);
translate([35,0,0]) curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.78,samples=240);
translate([110,0,0]) curve_gear_cassini_pair(.8,34,4,4.8,focus_ratio=.78,samples=240,together_built=false);
