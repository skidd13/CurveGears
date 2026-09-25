/***
 * @function epitrochoid_curve_gear_mate
 * @brief Render the conjugate Epitrochoid mate generated from the driver pitch curve.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_mate.scad`](functions/epitrochoid/curve_gear_epitrochoid_mate.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_mate.png curve_gear_epitrochoid_mate example preview
 */
include <../../../src/epitrochoid/mate.scad>;
$fn=64;
curve_gear_epitrochoid_mate(.8,34,4,4.8,major_ratio=4,rolling_ratio=1,offset_ratio=.5,samples=240);
