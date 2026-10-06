/***
 * @function curve_gear_hypotrochoid_body_2d
 * @brief Render the hypotrochoid body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.png hypotrochoid 2D body outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/hypotrochoid/gear.scad>;
curve_gear_hypotrochoid_body_2d(0.8, 34, 4.8, samples=240, body_offset=-2);
