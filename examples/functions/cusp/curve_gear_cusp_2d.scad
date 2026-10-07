/***
 * @function curve_gear_cusp_2d
 * @brief Render the complete cusp gear profile as flat 2D geometry.
 * Source: [`functions/cusp/curve_gear_cusp_2d.scad`](functions/cusp/curve_gear_cusp_2d.scad)
 * @image ../images/functions/cusp/curve_gear_cusp_2d.png cusp 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/cusp/gear.scad>;
include <../../palette.scad>;
color(example_driver_color)
curve_gear_cusp_2d(0.8, 36, 4.8, samples=720);
