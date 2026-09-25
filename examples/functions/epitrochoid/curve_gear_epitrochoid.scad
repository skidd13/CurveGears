/***
 * @function epitrochoid_curve_gear
 * @brief Render a scalloped Epitrochoid gear showing the rolling-pen profile.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid.scad`](functions/epitrochoid/curve_gear_epitrochoid.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid.png curve_gear_epitrochoid example preview
 */
include <../../../src/epitrochoid/mate.scad>;
$fn=64;
module _main_example_epitrochoid() {
curve_gear_epitrochoid(.8,34,4,4.8,major_ratio=4,rolling_ratio=1,offset_ratio=.5,samples=240);
}
_main_example_epitrochoid();
