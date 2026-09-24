/***
 * @function pascal_curve_gear
 * @brief Render a Pascal gear from the documented pitch-curve family.
 * Source: [`functions/pascal/curve_gear_pascal.scad`](functions/pascal/curve_gear_pascal.scad)
 * @image ../images/functions/pascal/curve_gear_pascal.png curve_gear_pascal example preview
 */
include <../../../src/pascal/mate.scad>;
$fn=64;
curve_gear_pascal(.8,34,4,4.8,eccentricity=.35,samples=240);
