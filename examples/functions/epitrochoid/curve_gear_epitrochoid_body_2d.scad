/***
 * @function curve_gear_epitrochoid_body_2d
 * @brief Render the epitrochoid body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_body_2d.scad`](functions/epitrochoid/curve_gear_epitrochoid_body_2d.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body_2d.png epitrochoid 2D body profile
 */
include <../../../src/epitrochoid/gear.scad>;
curve_gear_epitrochoid_body_2d(0.8, 34, 4.8, samples=240, body_offset=-2);
