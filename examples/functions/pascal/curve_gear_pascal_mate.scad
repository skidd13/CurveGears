/***
 * @function pascal_curve_gear_mate
 * @brief Render the conjugate Pascal mate generated from the driver pitch curve.
 * Source: [`functions/pascal/curve_gear_pascal_mate.scad`](functions/pascal/curve_gear_pascal_mate.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_mate.png curve_gear_pascal_mate example preview
 */
include <../../../src/pascal/mate.scad>;
$fn=64;
curve_gear_pascal_mate(.8,34,4,4.8,eccentricity=.35,samples=240);
