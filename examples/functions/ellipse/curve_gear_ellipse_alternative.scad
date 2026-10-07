/***
 * @function ellipse_curve_gear_alternative
 * @brief Ellipse alternative: Eccentricity 0.94 produces a long narrow ellipse rather than the canonical 0.72 oval. The sharper ends and narrow transverse span reveal where tooth placement becomes demanding.
 * Source: [`functions/ellipse/curve_gear_ellipse_alternative.scad`](functions/ellipse/curve_gear_ellipse_alternative.scad)
 * Eccentricity 0.94 produces a long narrow ellipse rather than the canonical 0.72 oval. The sharper ends and narrow transverse span reveal where tooth placement becomes demanding.
 * @image ../images/functions/ellipse/curve_gear_ellipse_alternative.png Ellipse gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/ellipse/gear.scad>;
include <../../../src/ellipse/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_ellipse(pair=false,view="gear") {
    if (pair)
        curve_gear_ellipse_pair(.7,60,3,4.8,eccentricity=.94,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_ellipse_body(.7,60,3,4.8,eccentricity=.94,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_ellipse_mate(.7,60,3,4.8,eccentricity=.94,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_ellipse_2d(.7,60,4.8,eccentricity=.94,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_ellipse_body_2d(.7,60,4.8,eccentricity=.94,samples=360);
    else
        color(example_driver_color)
            curve_gear_ellipse(.7,60,3,4.8,eccentricity=.94,samples=360);
}
_alternative_example_ellipse();
