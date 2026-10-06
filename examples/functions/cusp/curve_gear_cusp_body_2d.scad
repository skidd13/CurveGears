/***
 * @function curve_gear_cusp_body_2d
 * @brief Render the cusp body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/cusp/curve_gear_cusp_body_2d.scad`](functions/cusp/curve_gear_cusp_body_2d.scad)
 * @image ../images/functions/cusp/curve_gear_cusp_body_2d.png cusp 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/cusp/gear.scad>;
curve_gear_cusp_body_2d(0.8, 36, 4.8, samples=720);
