/***
 * @function bezier_curve_gear
 * @brief Render a smooth asymmetric Bézier gear with a soft teardrop outline.
 * Source: [`functions/bezier/curve_gear_bezier.scad`](functions/bezier/curve_gear_bezier.scad)
 * @image ../images/functions/bezier/curve_gear_bezier.png curve_gear_bezier example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/bezier/pair.scad>;
include <../../palette.scad>;
$fn=64;
function _main_example_bezier_controls() = [
        [1.25,0],[1.25,.65],[.85,1.15],[0,1.15],
        [-.85,1.15],[-1.25,.65],[-1.25,0],
        [-1.25,-.45],[-.65,-.8],[0,-.8],
        [.65,-.8],[1.25,-.45],[1.25,0]
    ];
module _main_example_bezier_view(view="gear") {
    if (view=="pair")
        curve_gear_bezier_pair(.8,34,4,4.8,control_points=_main_example_bezier_controls(),samples=240,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_bezier_body(.8,34,4,4.8,control_points=_main_example_bezier_controls(),samples=240);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_bezier_mate(.8,34,4,4.8,control_points=_main_example_bezier_controls(),samples=240);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_bezier_2d(.8,34,4.8,control_points=_main_example_bezier_controls(),samples=240);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_bezier_body_2d(.8,34,4.8,control_points=_main_example_bezier_controls(),samples=240);
    else
        color(example_driver_color)
            curve_gear_bezier(.8,34,4,4.8,control_points=_main_example_bezier_controls(),samples=240);
}
module _main_example_bezier() { _main_example_bezier_view(); }
_main_example_bezier();
