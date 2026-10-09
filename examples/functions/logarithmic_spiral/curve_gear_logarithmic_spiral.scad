/***
 * @function logarithmic_spiral_curve_gear
 * @brief Render a Logarithmic spiral gear from the documented pitch-curve family.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad)
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png curve_gear_logarithmic_spiral example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/logarithmic_spiral/mate.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/logarithmic_spiral/pair.scad>;

module _main_example_logarithmic_spiral_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_logarithmic_spiral_pair(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_logarithmic_spiral_body(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_logarithmic_spiral_mate(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_logarithmic_spiral_2d(0.8, 34, 4.8, sectors=1, growth_rate=1.17, samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_logarithmic_spiral_body_2d(0.8, 34, 4.8, sectors=1, growth_rate=1.17, samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
    }
}
module _main_example_logarithmic_spiral() { _main_example_logarithmic_spiral_view(); }
_main_example_logarithmic_spiral();
