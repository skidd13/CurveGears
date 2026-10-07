/***
 * @function curve_gear_bezier_body_2d
 * @brief Render the bezier body as flat 2D geometry with a 2 mm inward outer-contour shrink.
 * Source: [`functions/bezier/curve_gear_bezier_body_2d.scad`](functions/bezier/curve_gear_bezier_body_2d.scad)
 * @image ../images/functions/bezier/curve_gear_bezier_body_2d.png bezier 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/bezier/gear.scad>;
include <../../palette.scad>;
example_controls=[
    [1.25,0],[1.25,.65],[.85,1.15],[0,1.15],
    [-.85,1.15],[-1.25,.65],[-1.25,0],
    [-1.25,-.45],[-.65,-.8],[0,-.8],
    [.65,-.8],[1.25,-.45],[1.25,0]
];
color(example_driver_color)
curve_gear_bezier_body_2d(0.8, 34, 4.8, control_points=example_controls, samples=240);
