/***
 * @function cassini_curve_gear
 * @brief Render a thin-waisted peanut-shaped Cassini gear.
 * Source: [`functions/cassini/curve_gear_cassini.scad`](functions/cassini/curve_gear_cassini.scad)
 * @image ../images/functions/cassini/curve_gear_cassini.png curve_gear_cassini example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cassini/gear.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/cassini/pair.scad>;

module _main_example_cassini_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_cassini_pair(.8,34,4,4.8,focus_ratio=.92,samples=360,phase=37,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_cassini_body(.8,34,4,4.8,focus_ratio=.92,samples=360);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_cassini_mate(.8,34,4,4.8,focus_ratio=.92,samples=360);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_cassini_2d(0.8, 34, 4.8, focus_ratio=0.92, samples=360);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_cassini_body_2d(0.8, 34, 4.8, focus_ratio=0.92, samples=360);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_cassini(.8,34,4,4.8,focus_ratio=.92,samples=360);
    }
}
module _main_example_cassini() { _main_example_cassini_view(); }
_main_example_cassini();
