/***
 * @function pascal_curve_gear_pair
 * @brief Render a complete Pascal gear pair with derived conjugate motion.
 * Source: [`functions/pascal/curve_gear_pascal_pair.scad`](functions/pascal/curve_gear_pascal_pair.scad)
 * @image ../images/functions/pascal/curve_gear_pascal_pair.png curve_gear_pascal_pair example preview
 */
include <../../../src/pascal/pair.scad>;
$fn=64;
curve_gear_pascal_pair(.8,34,4,4.8,eccentricity=.35,samples=240,phase=37);
