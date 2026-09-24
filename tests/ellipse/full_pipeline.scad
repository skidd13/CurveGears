/***
 * @function ellipse_full_pipeline
 * @brief Verify the complete Ellipse gear, mate, and pair entry points.
 * Source: [`ellipse/full_pipeline.scad`](ellipse/full_pipeline.scad)
 */
include <../../src/ellipse/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_ellipse(.8,34,4,4.8,eccentricity=.72,samples=120);
translate([-35,0,0]) curve_gear_ellipse_body(.8,34,4,4.8,eccentricity=.72,samples=120);
translate([35,0,0]) curve_gear_ellipse_mate(.8,34,4,4.8,eccentricity=.72,samples=120);
translate([100,0,0]) curve_gear_ellipse_pair(.8,34,4,4.8,eccentricity=.72,samples=120);
