/***
 * @function bezier_curve_gear_mate
 * @brief Render the conjugate Bézier mate generated from the driver pitch curve.
 * Source: [`functions/bezier/curve_gear_bezier_mate.scad`](functions/bezier/curve_gear_bezier_mate.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_mate.png curve_gear_bezier_mate example preview
 */
include <../../../src/bezier/mate.scad>;
$fn=64;
example_controls=[
    [1.25,0],[1.25,.65],[.85,1.15],[0,1.15],
    [-.85,1.15],[-1.25,.65],[-1.25,0],
    [-1.25,-.45],[-.65,-.8],[0,-.8],
    [.65,-.8],[1.25,-.45],[1.25,0]
];
curve_gear_bezier_mate(.8,34,4,4.8,control_points=example_controls,samples=240);
