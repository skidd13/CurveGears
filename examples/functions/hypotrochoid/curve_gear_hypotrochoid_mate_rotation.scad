/***
 * @function hypotrochoid_curve_gear_mate_rotation
 * @brief Show the Hypotrochoid mate-rotation calculation used for pair assembly.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_mate_rotation.scad)
 */
include <../../../src/hypotrochoid/mate.scad>;
echo("curve_gear_hypotrochoid_mate_rotation", curve_gear_hypotrochoid_mate_rotation(.8,34,3,1,.35,360,37));
