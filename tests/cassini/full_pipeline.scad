/***
 * @function cassini_full_pipeline
 * @brief Verify the complete Cassini gear, mate, and pair entry points.
 * Source: [`cassini/full_pipeline.scad`](cassini/full_pipeline.scad)
 */
include <../../src/cassini/gear.scad>
include <../../src/cassini/mate.scad>
include <../../src/cassini/pair.scad>

assert(max([for(ratio=[0,.2,.78,.999],samples=[120,360,1440])
    abs(_cg_cassini_max_radius(2,ratio,samples)-
        max([for(i=[0:samples-1]) _cg_cassini_radius(2,ratio,360*i/samples)]))])<1e-12,
    "analytic Cassini maximum differs from the supported sampled branch");

$fn=96;
translate([-110,0,0]) curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=240);
translate([-35,0,0]) curve_gear_cassini_body(.8,34,4,4.8,focus_ratio=.78,samples=240);
translate([35,0,0]) curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.78,samples=240);
translate([110,0,0]) curve_gear_cassini_pair(.8,34,4,4.8,focus_ratio=.78,samples=240,together_built=false);
