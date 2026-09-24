/***
 * @function ellipse_pair_pipeline
 * @brief Verify Ellipse pair assembly and conjugate mate placement.
 * Source: [`ellipse/pair_pipeline.scad`](ellipse/pair_pipeline.scad)
 */
include <../../src/ellipse/pair.scad>

$fn=96;
curve_gear_ellipse_pair(.8,34,4,4.8,eccentricity=.72,pressure_angle=20,samples=120,phase=17,backlash=.02,clearance=.01);
translate([70,0,0])
    curve_gear_ellipse_mate(.8,34,4,4.8,eccentricity=.72,pressure_angle=20,samples=120,backlash=.02,clearance=.01);
