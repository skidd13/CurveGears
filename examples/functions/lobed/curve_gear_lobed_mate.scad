/***
 * @function lobed_curve_gear_mate
 * @brief Render the conjugate Lobed mate generated from the driver pitch curve.
 * Source: [`functions/lobed/curve_gear_lobed_mate.scad`](functions/lobed/curve_gear_lobed_mate.scad)
 * @image ../images/functions/lobed/curve_gear_lobed_mate.png curve_gear_lobed_mate example preview
 */
include <../../../src/lobed/mate.scad>;
$fn=64;
curve_gear_lobed_mate(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
