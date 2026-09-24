/***
 * @function epitrochoid_curve_gear_pair
 * @brief Render a complete Epitrochoid gear pair with derived conjugate motion.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_pair.scad`](functions/epitrochoid/curve_gear_epitrochoid_pair.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_pair.png curve_gear_epitrochoid_pair example preview
 */
include <../../../src/epitrochoid/pair.scad>;
$fn=64;
curve_gear_epitrochoid_pair(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=240,phase=37);
