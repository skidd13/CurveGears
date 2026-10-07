/**
 * @function cusp_curve_gear_pair
 * @brief Render the deltoid cusp gear with its conjugate motion mate.
 * Source: [`cusp/curve_gear_cusp_pair.scad`](cusp/curve_gear_cusp_pair.scad)
 */
use <../../../src/cusp/pair.scad>
include <../../palette.scad>;
curve_gear_cusp_pair(1.2,36,4,4.8,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
