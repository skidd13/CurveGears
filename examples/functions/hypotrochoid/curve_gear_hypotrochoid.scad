/***
 * @function hypotrochoid_curve_gear
 * @brief Render a triangular inner-rolling Hypotrochoid form.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid.scad`](functions/hypotrochoid/curve_gear_hypotrochoid.scad)
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid.png curve_gear_hypotrochoid example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/hypotrochoid/gear.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/hypotrochoid/pair.scad>;

module _main_example_hypotrochoid_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_hypotrochoid_pair(.8,34,4,4.8,samples=360,phase=37,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_hypotrochoid_body(.8,34,4,4.8,samples=360);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_hypotrochoid_mate(.8,34,4,4.8,samples=360);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_hypotrochoid_2d(0.8, 34, 4.8, samples=360);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_hypotrochoid_body_2d(0.8, 34, 4.8, samples=360);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_hypotrochoid(.8,34,4,4.8,samples=360);
    }
}
module _main_example_hypotrochoid() { _main_example_hypotrochoid_view(); }
_main_example_hypotrochoid();
