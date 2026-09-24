/***
 * @function ellipse_curve_gear_pair
 * @brief Render a complete Ellipse gear pair with derived conjugate motion.
 * Source: [`functions/ellipse/curve_gear_ellipse_pair.scad`](functions/ellipse/curve_gear_ellipse_pair.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse_pair.png curve_gear_ellipse_pair example preview
 */
include <../../../src/ellipse/pair.scad>;
$fn=64;
curve_gear_ellipse_pair(.8,34,4,4.8,eccentricity=.72,samples=240,phase=37);
