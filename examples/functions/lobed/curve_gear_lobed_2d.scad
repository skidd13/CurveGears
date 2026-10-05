/***
 * @function curve_gear_lobed_2d
 * @brief Render the complete lobed gear profile as flat 2D geometry.
 * Source: [`functions/lobed/curve_gear_lobed_2d.scad`](functions/lobed/curve_gear_lobed_2d.scad)
 * @image ../images/functions/lobed/curve_gear_lobed_2d.png lobed 2D gear profile
 */
include <../../../src/lobed/gear.scad>;
curve_gear_lobed_2d(0.8, 34, 4.8, lobes=4, lobe_depth=0.13);
