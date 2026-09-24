/***
 * @file Bézier asymmetric pair alternative
 * @brief The same visibly non-circular Bézier curve and its derived mate.
 */
include <../../../src/bezier/pair.scad>;

$fn=64;
asymmetric_controls=[
    [1.55,0],[1.55,.8],[1.0,1.55],[0,1.55],
    [-1.0,1.55],[-1.55,.8],[-1.55,0],
    [-1.55,-.35],[-.8,-.65],[0,-.65],
    [.8,-.65],[1.55,-.35],[1.55,0]
];
curve_gear_bezier_pair(.8,34,4,4.8,control_points=asymmetric_controls,samples=360,together_built=false);
