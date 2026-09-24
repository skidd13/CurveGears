/***
 * @function bezier_mate_pipeline
 * @brief Verify Bézier mate construction through the shared pair pipeline.
 * Source: [`bezier/mate_pipeline.scad`](bezier/mate_pipeline.scad)
 */
include <../../src/bezier/mate.scad>
include <../../src/bezier/pair.scad>

curve_gear_bezier_mate(.8,34,4,4.8,samples=240);
assert(curve_gear_bezier_mate_centre_distance(.8,34,samples=240)>0,"Bézier mate centre distance missing");
assert(curve_gear_bezier_mate_rotation(.8,34,samples=240,phase=0)!=undef,"Bézier mate phase mapping missing");
curve_gear_bezier_pair(.8,34,4,4.8,samples=240);
