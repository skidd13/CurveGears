/***
 * @function pascal_curve_gear
 * @brief Render a heart-like Pascal gear with a pronounced non-convex waist.
 * Source: [`functions/pascal/curve_gear_pascal.scad`](functions/pascal/curve_gear_pascal.scad)
 * @image ../images/functions/pascal/curve_gear_pascal.png curve_gear_pascal example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/pascal/mate.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/pascal/pair.scad>;

module _main_example_pascal_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_pascal_pair(.8,34,4,4.8,eccentricity=.60,samples=240,phase=37,experimental_nonconvex=true,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_pascal_body(.8,34,4,4.8,eccentricity=.60,samples=240);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_pascal_mate(.8,34,4,4.8,eccentricity=.60,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_pascal_2d(0.8, 34, 4.8, eccentricity=0.60, samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_pascal_body_2d(0.8, 34, 4.8, eccentricity=0.60, samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_pascal(.8,34,4,4.8,eccentricity=.60,samples=240);
    }
}
module _main_example_pascal() { _main_example_pascal_view(); }
_main_example_pascal();
