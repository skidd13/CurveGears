/***
 * @function hypotrochoid_curve_gear_mate
 * @brief Render the conjugate Hypotrochoid mate generated from the driver pitch curve.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_mate.png curve_gear_hypotrochoid_mate example preview
 */
include <../../../src/hypotrochoid/mate.scad>;
$fn=64;
curve_gear_hypotrochoid_mate(.8,34,4,4.8,samples=360);
