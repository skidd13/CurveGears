/***
 * @function lobed_curve_gear
 * @brief Render a square four-lobed gear with a clear radial rhythm.
 * Source: [`functions/lobed/curve_gear_lobed.scad`](functions/lobed/curve_gear_lobed.scad)
 * @image ../images/functions/lobed/curve_gear_lobed.png curve_gear_lobed example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/lobed/mate.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/lobed/pair.scad>;

module _main_example_lobed_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_lobed_pair(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240,phase=37,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_lobed_body(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_lobed_mate(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_lobed_2d(0.8, 34, 4.8, lobes=4, lobe_depth=0.13, samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_lobed_body_2d(0.8, 34, 4.8, lobes=4, lobe_depth=0.13, samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_lobed(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
    }
}
module _main_example_lobed() { _main_example_lobed_view(); }
_main_example_lobed();
