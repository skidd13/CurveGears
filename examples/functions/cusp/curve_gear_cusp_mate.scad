/**
 * @function cusp_curve_gear_mate
 * @brief Render the standalone deltoid cusp gear mate.
 * Source: [`cusp/curve_gear_cusp_mate.scad`](cusp/curve_gear_cusp_mate.scad)
 */
use <../../../src/cusp/mate.scad>
include <../../palette.scad>;
color(example_mate_color)
curve_gear_cusp_mate(1.2,36,4,4.8);
