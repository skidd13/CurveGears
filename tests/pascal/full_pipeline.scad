/***
 * @function pascal_full_pipeline
 * @brief Verify the complete Pascal gear, mate, and pair entry points.
 * Source: [`pascal/full_pipeline.scad`](pascal/full_pipeline.scad)
 */
// @regression: manual — the experimental non-convex mate path is covered by test-full, not smoke validation.
include <../../src/pascal/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_pascal(.8,34,4,4.8,eccentricity=.68,samples=120);
translate([-35,0,0]) curve_gear_pascal_body(.8,34,4,4.8,eccentricity=.68,samples=120);
translate([35,0,0]) curve_gear_pascal_mate(.8,34,4,4.8,eccentricity=.68,samples=120);
translate([100,0,0]) curve_gear_pascal_pair(.8,34,4,4.8,eccentricity=.68,samples=120,experimental_nonconvex=true);
