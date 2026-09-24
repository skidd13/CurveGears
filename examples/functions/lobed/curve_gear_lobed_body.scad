/***
 * @function lobed_curve_gear_body
 * @brief Render the Lobed body before tooth placement.
 * Source: [`functions/lobed/curve_gear_lobed_body.scad`](functions/lobed/curve_gear_lobed_body.scad)
 * @image ../images/functions/lobed/curve_gear_lobed_body.png curve_gear_lobed_body example preview
 */
include <../../../src/lobed/mate.scad>;
$fn=64;
curve_gear_lobed_body(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
