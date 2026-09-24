/***
 * @function hypotrochoid_curve_gear_pair
 * @brief Render a complete Hypotrochoid gear pair with derived conjugate motion.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_pair.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair.png curve_gear_hypotrochoid_pair example preview
 */
include <../../../src/hypotrochoid/pair.scad>;
$fn=64;
curve_gear_hypotrochoid_pair(.8,34,4,4.8,samples=360,phase=37);
