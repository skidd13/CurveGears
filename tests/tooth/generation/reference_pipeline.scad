/***
 * @function tooth_generation_reference_pipeline
 * @brief Render the compact mathematical reference tooth for STL comparison.
 * Source: [`tooth/generation/reference_pipeline.scad`](tooth/generation/reference_pipeline.scad)
 */
include <../../../src/common/curve_gears_math.scad>
include <reference.scad>

$fn=96;
reference_oracle_tooth(.8,34,4,20);
