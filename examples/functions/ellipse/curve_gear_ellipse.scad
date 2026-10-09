/***
 * @function ellipse_curve_gear
 * @brief Render a Ellipse gear from the documented pitch-curve family.
 * Source: [`functions/ellipse/curve_gear_ellipse.scad`](functions/ellipse/curve_gear_ellipse.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse.png curve_gear_ellipse example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/ellipse/mate.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/ellipse/pair.scad>;

module _main_example_ellipse_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_ellipse_pair(.8,34,4,4.8,eccentricity=.72,samples=240,phase=37,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_ellipse_body(.8,34,4,4.8,eccentricity=.72,samples=240);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_ellipse_mate(.8,34,4,4.8,eccentricity=.72,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_ellipse_2d(0.8, 34, 4.8, eccentricity=0.72, samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_ellipse_body_2d(0.8, 34, 4.8, eccentricity=0.72, samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_ellipse(.8,34,4,4.8,eccentricity=.72,samples=240);
    }
}
module _main_example_ellipse() { _main_example_ellipse_view(); }
_main_example_ellipse();
