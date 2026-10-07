/***
 * @function pascal_curve_gear_mate
 * @brief Render the conjugate Pascal mate generated from the driver pitch curve.
 * Source: [`functions/pascal/curve_gear_pascal_mate.scad`](functions/pascal/curve_gear_pascal_mate.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_mate.png curve_gear_pascal_mate example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/pascal/mate.scad>;
include <../../palette.scad>;
$fn=64;
color(example_mate_color)
curve_gear_pascal_mate(.8,34,4,4.8,eccentricity=.60,samples=240);
