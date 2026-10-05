/***
 * @function curve_gear_hypotrochoid_2d
 * @brief Render the complete hypotrochoid gear profile as flat 2D geometry.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_2d.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_2d.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_2d.png hypotrochoid 2D gear profile
 */
include <../../../src/hypotrochoid/gear.scad>;
curve_gear_hypotrochoid_2d(0.8, 34, 4.8, samples=240);
