/***
 * @function lobed_curve_gear_pair
 * @brief Render a complete Lobed gear pair with derived conjugate motion.
 * Source: [`functions/lobed/curve_gear_lobed_pair.scad`](functions/lobed/curve_gear_lobed_pair.scad)
 * @image ../images/functions/lobed/curve_gear_lobed_pair.png curve_gear_lobed_pair example preview
 */
include <../../../src/lobed/pair.scad>;
$fn=64;
curve_gear_lobed_pair(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240,phase=37);
