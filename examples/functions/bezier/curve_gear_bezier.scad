/***
 * @function bezier_curve_gear
 * @brief Render a smooth asymmetric Bézier gear with a soft teardrop outline.
 * Source: [`functions/bezier/curve_gear_bezier.scad`](functions/bezier/curve_gear_bezier.scad)
 * @image ../images/functions/bezier/curve_gear_bezier.png curve_gear_bezier example preview
 */
include <../../../src/bezier/base.scad>;
$fn=64;
module _main_example_bezier() {
    example_controls=[
        [1.25,0],[1.25,.65],[.85,1.15],[0,1.15],
        [-.85,1.15],[-1.25,.65],[-1.25,0],
        [-1.25,-.45],[-.65,-.8],[0,-.8],
        [.65,-.8],[1.25,-.45],[1.25,0]
    ];
    curve_gear_bezier(.8,34,4,4.8,control_points=example_controls,samples=240);
}
_main_example_bezier();
