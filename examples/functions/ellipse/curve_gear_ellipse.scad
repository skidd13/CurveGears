/***
 * @function ellipse_curve_gear
 * @brief Render a Ellipse gear from the documented pitch-curve family.
 * Source: [`functions/ellipse/curve_gear_ellipse.scad`](functions/ellipse/curve_gear_ellipse.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse.png curve_gear_ellipse example preview
 */
include <../../../src/ellipse/mate.scad>;
$fn=64;
module _main_example_ellipse() {
    curve_gear_ellipse(.8,34,4,4.8,eccentricity=.72,samples=240);
}
_main_example_ellipse();
