/***
 * @function pascal_curve_gear
 * @brief Render a heart-like Pascal gear with a pronounced non-convex waist.
 * Source: [`functions/pascal/curve_gear_pascal.scad`](functions/pascal/curve_gear_pascal.scad)
 * @image ../images/functions/pascal/curve_gear_pascal.png curve_gear_pascal example preview
 */
include <../../../src/pascal/mate.scad>;
$fn=64;
module _main_example_pascal() {
    curve_gear_pascal(.8,34,4,2.0,eccentricity=.60,samples=240);
}
_main_example_pascal();
