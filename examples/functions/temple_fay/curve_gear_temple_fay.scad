/***
 * @function curve_gear_temple_fay_example
 * @brief Temple Fay butterfly gear example with broad lobes and a deep waist.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay.png temple fay butterfly example preview
*/
include <../../../src/temple_fay/gear.scad>
include <../../palette.scad>;
include <../../../src/temple_fay/pair.scad>;

$fn=96;

module _main_example_temple_fay_view(view="gear") {
    if (view=="pair") {
        curve_gear_temple_fay_pair(.7,48,3,4.8,wing=.38,fold=.14,samples=720,phase=69.7,together_built=true,backlash=.5,clearance=0,tooth_phase=90,mate_tooth_phase_offset=180,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if (view=="body") {
        color(example_driver_color)
            curve_gear_temple_fay_body(.7,48,3,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    }
    else if (view=="mate") {
        color(example_mate_color)
            curve_gear_temple_fay_mate(.7,48,3,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    }
    else if (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_temple_fay_2d(.7,48,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    }
    else if (view=="body_2d") {
        color(example_driver_color)
            curve_gear_temple_fay_body_2d(.7,48,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    }
    else {
        color(example_driver_color)
            curve_gear_temple_fay(.7,48,3,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    }
}
module _main_example_temple_fay() { _main_example_temple_fay_view(); }
_main_example_temple_fay();
