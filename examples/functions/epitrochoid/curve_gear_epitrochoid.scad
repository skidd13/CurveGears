/***
 * @function epitrochoid_curve_gear
 * @brief Render a scalloped Epitrochoid gear showing the rolling-pen profile.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid.scad`](functions/epitrochoid/curve_gear_epitrochoid.scad)
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid.png curve_gear_epitrochoid example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/epitrochoid/mate.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/epitrochoid/pair.scad>;

module _main_example_epitrochoid_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_epitrochoid_pair(.8,34,4,4.8,major_ratio=4,rolling_ratio=1,offset_ratio=.5,samples=240,phase=37,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_epitrochoid_body(.8,34,4,4.8,major_ratio=4,rolling_ratio=1,offset_ratio=.5,samples=240);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_epitrochoid_mate(.8,34,4,4.8,major_ratio=4,rolling_ratio=1,offset_ratio=.5,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_epitrochoid_2d(0.8, 34, 4.8, major_ratio=4, rolling_ratio=1, offset_ratio=0.5, samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_epitrochoid_body_2d(0.8, 34, 4.8, major_ratio=4, rolling_ratio=1, offset_ratio=0.5, samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_epitrochoid(.8,34,4,4.8,major_ratio=4,rolling_ratio=1,offset_ratio=.5,samples=240);
    }
}
module _main_example_epitrochoid() { _main_example_epitrochoid_view(); }
_main_example_epitrochoid();
