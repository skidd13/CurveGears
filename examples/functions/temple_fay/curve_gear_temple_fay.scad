/***
 * @function curve_gear_temple_fay_example
 * @brief Temple Fay gear example.
  * @image ../images/functions/temple_fay/curve_gear_temple_fay.png temple fay example preview
*/
include <../../../src/temple_fay/gear.scad>
include <../../palette.scad>;
include <../../../src/temple_fay/pair.scad>;

module _main_example_temple_fay_view(view="gear") {
    if (view=="pair") {
            curve_gear_temple_fay_pair(.8,34,4,4.8,wing=.08,fold=.02,samples=240,phase=0,together_built=true,backlash=.5,clearance=.5,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if  (view=="body") {
        color(example_driver_color)
            curve_gear_temple_fay_body(.8,34,4,4.8,samples=240);
    }
    else if  (view=="mate") {
        color(example_mate_color)
            curve_gear_temple_fay_mate(.8,34,4,4.8,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_temple_fay_2d(.8,34,4.8,samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_temple_fay_body_2d(.8,34,4.8,samples=240);
    }
    else {
        color(example_driver_color)
            curve_gear_temple_fay(.8,34,4,4.8,samples=240);
    }
}
module _main_example_temple_fay() { _main_example_temple_fay_view(); }
_main_example_temple_fay();
