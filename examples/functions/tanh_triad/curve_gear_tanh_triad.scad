/** @function curve_gear_tanh_triad_example
 * @brief Tanh Triad gear example.
  * @image ../images/functions/tanh_triad/curve_gear_tanh_triad.png tanh triad example preview
*/
include <../../../src/tanh_triad/gear.scad>
include <../../palette.scad>;
$fn=64;
include <../../../src/tanh_triad/pair.scad>;

module _main_example_tanh_triad_view(view="gear") {
    if (view=="pair") {
            curve_gear_tanh_triad_pair(.8,34,4,4.8,samples=240,together_built=true,backlash=.8,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if  (view=="body") {
        color(example_driver_color)
            curve_gear_tanh_triad_body(.8,34,4,4.8,samples=240);
    }
    else if  (view=="mate") {
        color(example_mate_color)
            curve_gear_tanh_triad_mate(.8,34,4,4.8,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_tanh_triad_2d(.8,34,4.8,samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_tanh_triad_body_2d(.8,34,4.8,samples=240,body_offset=-2);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_tanh_triad(.8,34,4,4.8,samples=240);
    }
}
module _main_example_tanh_triad() { _main_example_tanh_triad_view(); }
_main_example_tanh_triad();
