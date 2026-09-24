/***
 * @function epitrochoid_curve_gear_body
 * @brief Render the Epitrochoid body before tooth placement.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_body.scad`](functions/epitrochoid/curve_gear_epitrochoid_body.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body.png curve_gear_epitrochoid_body example preview
 */
include <../../../src/epitrochoid/mate.scad>;
$fn=64;
curve_gear_epitrochoid_body(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=240);
