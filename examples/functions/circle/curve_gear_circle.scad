/***
 * @function circle_curve_gear
 * @brief Render a Circle gear from the documented pitch-curve family.
 * Source: [`functions/circle/curve_gear_circle.scad`](functions/circle/curve_gear_circle.scad)
 * @image ../images/functions/circle/curve_gear_circle.png curve gear circle preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/circle/gear.scad>;
include <../../palette.scad>;
include <../../../src/circle/pair.scad>;

module _main_example_circle_view(view="gear") {
    if (view=="pair") {
            curve_gear_circle_pair(.8,34,4,4.8,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        color(example_driver_color)
            curve_gear_circle_body(.8,34,4,4.8);
    }
    else if  (view=="mate") {
        color(example_mate_color)
            curve_gear_circle_mate(.8,34,4,4.8);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_circle_2d(0.8, 34, 4.8);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_circle_body_2d(0.8, 34, 4.8);
    }
    else {
        color(example_driver_color)
            curve_gear_circle(.8,34,4,4.8);
    }
}
module _main_example_circle() { _main_example_circle_view(); }
_main_example_circle();
