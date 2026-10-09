/***
 * @function curve_gear_cosine_quintic_example
 * @brief Cosine Quintic gear example.
  * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic.png cosine quintic example preview
*/
include <../../../src/cosine_quintic/gear.scad>
include <../../palette.scad>;
include <../../../src/cosine_quintic/pair.scad>;

module _main_example_cosine_quintic_view(view="gear") {
    if (view=="pair") {
            curve_gear_cosine_quintic_pair(.8,34,4,4.8,samples=240,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if  (view=="body") {
        color(example_driver_color)
            curve_gear_cosine_quintic_body(.8,34,4,4.8,samples=240);
    }
    else if  (view=="mate") {
        color(example_mate_color)
            curve_gear_cosine_quintic_mate(.8,34,4,4.8,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_cosine_quintic_2d(.8,34,4.8,samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_cosine_quintic_body_2d(.8,34,4.8,samples=240);
    }
    else {
        color(example_driver_color)
            curve_gear_cosine_quintic(.8,34,4,4.8,samples=240);
    }
}
module _main_example_cosine_quintic() { _main_example_cosine_quintic_view(); }
_main_example_cosine_quintic();
