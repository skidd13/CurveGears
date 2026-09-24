/***
 * @function hypotrochoid_curve_gear
 * @brief Render a triangular inner-rolling Hypotrochoid form.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid.scad`](functions/hypotrochoid/curve_gear_hypotrochoid.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid.png curve_gear_hypotrochoid example preview
 */
include <../../../src/hypotrochoid/gear.scad>;
$fn=64;
module _main_example_hypotrochoid() {
    curve_gear_hypotrochoid(.8,34,4,4.8,samples=360);
}
_main_example_hypotrochoid();
