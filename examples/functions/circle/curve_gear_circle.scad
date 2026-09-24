/***
 * @function circle_curve_gear
 * @brief Render a Circle gear from the documented pitch-curve family.
 * Source: [`functions/circle/curve_gear_circle.scad`](functions/circle/curve_gear_circle.scad)
 * @image ../images/functions/circle/curve_gear_circle.png curve gear circle preview
 */
include <../../../src/circle/gear.scad>
curve_gear_circle(.8,34,4,4.8);
