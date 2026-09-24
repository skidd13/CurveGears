/***
 * @function epitrochoid_curve_gear
 * @brief Render an Epitrochoid gear from the documented pitch-curve family.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid.scad`](functions/epitrochoid/curve_gear_epitrochoid.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid.png curve_gear_epitrochoid example preview
 */
include <../../../src/epitrochoid/mate.scad>;
$fn=64;
curve_gear_epitrochoid(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=240);
