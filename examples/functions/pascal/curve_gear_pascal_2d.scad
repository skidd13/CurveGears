/***
 * @function curve_gear_pascal_2d
 * @brief Render the complete pascal gear profile as flat 2D geometry.
 * Source: [`functions/pascal/curve_gear_pascal_2d.scad`](functions/pascal/curve_gear_pascal_2d.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_2d.png pascal 2D gear profile
 */
include <../../../src/pascal/gear.scad>;
curve_gear_pascal_2d(0.8, 34, 4.8, eccentricity=0.25);
