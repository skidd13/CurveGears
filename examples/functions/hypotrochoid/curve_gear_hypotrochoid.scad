/***
 * @function hypotrochoid_curve_gear
 * @brief Render a Hypotrochoid gear from the documented pitch-curve family.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid.scad`](functions/hypotrochoid/curve_gear_hypotrochoid.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid.png curve_gear_hypotrochoid example preview
 */
include <../../../src/hypotrochoid/gear.scad>;
$fn=64;
curve_gear_hypotrochoid(.8,34,4,4.8,samples=360);
