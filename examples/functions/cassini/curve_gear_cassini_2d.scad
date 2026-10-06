/***
 * @function curve_gear_cassini_2d
 * @brief Render the complete cassini gear profile as flat 2D geometry.
 * Source: [`functions/cassini/curve_gear_cassini_2d.scad`](functions/cassini/curve_gear_cassini_2d.scad)
 * @image ../images/functions/cassini/curve_gear_cassini_2d.png cassini 2D gear outline
 * @image ../images/table-spacer-512.png ⠀
 */
include <../../../src/cassini/gear.scad>;
curve_gear_cassini_2d(0.8, 34, 4.8, focus_ratio=0.78);
