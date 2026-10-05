/***
 * @function curve_gear_lobed_body_2d
 * @brief Render the lobed body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/lobed/curve_gear_lobed_body_2d.scad`](functions/lobed/curve_gear_lobed_body_2d.scad)
 * @image ../images/functions/lobed/curve_gear_lobed_body_2d.png lobed 2D body profile
 */
include <../../../src/lobed/gear.scad>;
curve_gear_lobed_body_2d(0.8, 34, 4.8, lobes=4, lobe_depth=0.13, body_offset=-2);
