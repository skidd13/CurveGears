/***
 * @function bezier_curve_gear_pair
 * @brief Render a complete Bézier gear pair with derived conjugate motion.
 * Source: [`functions/bezier/curve_gear_bezier_pair.scad`](functions/bezier/curve_gear_bezier_pair.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_pair.png curve_gear_bezier_pair example preview
 */
include <../../../src/bezier/pair.scad>;
$fn=64;
example_controls=[
    [1.25,0],[1.25,.65],[.85,1.15],[0,1.15],
    [-.85,1.15],[-1.25,.65],[-1.25,0],
    [-1.25,-.45],[-.65,-.8],[0,-.8],
    [.65,-.8],[1.25,-.45],[1.25,0]
];
curve_gear_bezier_pair(.8,34,4,4.8,control_points=example_controls,samples=240,together_built=false);
