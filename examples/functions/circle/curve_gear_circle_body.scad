/***
 * @function circle_curve_gear_body
 * @brief Render the Circle body before tooth placement.
 * Source: [`functions/circle/curve_gear_circle_body.scad`](functions/circle/curve_gear_circle_body.scad)
 * @image ../images/functions/circle/curve_gear_circle_body.png curve gear circle body preview
 */
include <../../../src/circle/gear.scad>
curve_gear_circle_body(.8,34,4,4.8);
