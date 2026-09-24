/***
 * @function hypotrochoid_curve_gear_pair_alternative
 * @brief curve_gear_hypotrochoid_pair alternative: Executable example for curve gear hypotrochoid pair alternative.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.png curve_gear_hypotrochoid_pair alternative preview
 */
include <../../../src/hypotrochoid/pair.scad>;
$fn=64;
curve_gear_hypotrochoid_pair(.8,34,4,4.8,samples=360,phase=37,together_built=false);
