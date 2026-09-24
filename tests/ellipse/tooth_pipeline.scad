/***
 * @function ellipse_tooth_pipeline
 * @brief Verify Ellipse tooth placement through the shared tooth pipeline.
 * Source: [`ellipse/tooth_pipeline.scad`](ellipse/tooth_pipeline.scad)
 */
include <../../src/ellipse/gear.scad>

$fn=96;
curve_gear_ellipse(.8,34,4,4.8,eccentricity=.72,samples=120);
