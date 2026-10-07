/***
 * @function cusp_five_cusp_pair_pipeline
 * @brief Fully render a five-cusp driver and its swept-envelope mate with the canonical bore.
 * Source: [`cusp/five_cusp_pair_pipeline.scad`](cusp/five_cusp_pair_pipeline.scad)
 */
include <../../src/cusp/pair.scad>
curve_gear_cusp_pair(.8,60,4,4.8,cusps=5,together_built=false);
