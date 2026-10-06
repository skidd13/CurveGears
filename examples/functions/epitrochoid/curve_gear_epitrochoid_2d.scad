/***
 * @function curve_gear_epitrochoid_2d
 * @brief Render the complete epitrochoid gear profile as flat 2D geometry.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_2d.scad`](functions/epitrochoid/curve_gear_epitrochoid_2d.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_2d.png epitrochoid 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/epitrochoid/gear.scad>;
curve_gear_epitrochoid_2d(0.8, 34, 4.8, major_ratio=4, rolling_ratio=1, offset_ratio=0.5, samples=240);
