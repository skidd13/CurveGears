/**
 * @function cosine_quintic_full_pipeline
 * @brief Verify the complete Cosine Quintic gear, mate and pair entry points.
 */
include <../../src/cosine_quintic/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_cosine_quintic(.8,34,4,4.8,samples=120);
translate([-35,0,0]) curve_gear_cosine_quintic_body(.8,34,4,4.8,samples=120);
translate([35,0,0]) curve_gear_cosine_quintic_mate(.8,34,4,4.8,samples=120);
translate([100,0,0]) curve_gear_cosine_quintic_pair(.8,34,4,4.8,samples=120);
