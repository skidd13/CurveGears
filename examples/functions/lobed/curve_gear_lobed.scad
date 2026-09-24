/***
 * @function lobed_curve_gear
 * @brief Render a square four-lobed gear with a clear radial rhythm.
 * Source: [`functions/lobed/curve_gear_lobed.scad`](functions/lobed/curve_gear_lobed.scad)
 * @image ../images/functions/lobed/curve_gear_lobed.png curve_gear_lobed example preview
 */
include <../../../src/lobed/mate.scad>;
$fn=64;
module _main_example_lobed() {
    curve_gear_lobed(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
}
_main_example_lobed();
