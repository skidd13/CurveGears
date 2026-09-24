/***
 * @function logarithmic_spiral_tooth_pipeline
 * @brief Verify Logarithmic spiral tooth placement through the shared tooth pipeline.
 * Source: [`logarithmic_spiral/tooth_pipeline.scad`](logarithmic_spiral/tooth_pipeline.scad)
 */
include <../../src/logarithmic_spiral/gear.scad>

$fn=96;
curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=120);
