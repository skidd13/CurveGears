/***
 * @function bezier_curve_gear_alternative
 * @brief Bézier alternative: An elongated asymmetric oval replaces the compact canonical outline. Unequal left/right handles and a narrow vertical span expose the effect of control-point geometry.
 * Source: [`functions/bezier/curve_gear_bezier_alternative.scad`](functions/bezier/curve_gear_bezier_alternative.scad)
 * An elongated asymmetric oval replaces the compact canonical outline. Unequal left/right handles and a narrow vertical span expose the effect of control-point geometry.
 * @image ../images/functions/bezier/curve_gear_bezier_alternative.png Bézier gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/bezier/gear.scad>;
include <../../../src/bezier/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_bezier(pair=false,view="gear") {
    controls=[[1.8,0],[1.8,.386],[.994,.7],[0,.7],[-.663,.7],[-1.2,.386],[-1.2,0],[-1.2,-.386],[-.663,-.7],[0,-.7],[.994,-.7],[1.8,-.386],[1.8,0]];
    if (pair)
        curve_gear_bezier_pair(.7,48,3,4.8,control_points=controls,samples=360,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_bezier_body(.7,48,3,4.8,control_points=controls,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_bezier_mate(.7,48,3,4.8,control_points=controls,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_bezier_2d(.7,48,4.8,control_points=controls,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_bezier_body_2d(.7,48,4.8,control_points=controls,samples=360);
    else
        color(example_driver_color)
            curve_gear_bezier(.7,48,3,4.8,control_points=controls,samples=360);
}
_alternative_example_bezier();
