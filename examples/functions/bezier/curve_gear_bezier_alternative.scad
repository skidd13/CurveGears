/***
 * @function bezier_curve_gear_alternative
 * @brief Bézier asymmetric alternative: A visibly non-circular but radially admissible Bézier pitch curve.
 * Source: [`functions/bezier/curve_gear_bezier_alternative.scad`](functions/bezier/curve_gear_bezier_alternative.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_alternative.png Bézier asymmetric alternative preview
 */
include <../../../src/bezier/gear.scad>;

$fn=64;
asymmetric_controls=[
    [1.55,0],[1.55,.8],[1.0,1.55],[0,1.55],
    [-1.0,1.55],[-1.55,.8],[-1.55,0],
    [-1.55,-.35],[-.8,-.65],[0,-.65],
    [.8,-.65],[1.55,-.35],[1.55,0]
];
curve_gear_bezier(.8,34,4,4.8,control_points=asymmetric_controls,samples=360);
