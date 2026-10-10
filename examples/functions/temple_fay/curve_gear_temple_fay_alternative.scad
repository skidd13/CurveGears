/***
 * @function temple_fay_curve_gear_alternative
 * @brief Temple Fay extreme butterfly alternative: Wing 0.38 and fold 0.14 create a deep waist and broad lobes.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_alternative.scad)
 * All alternative views use wing 0.38 and fold 0.14 for an extreme butterfly outline.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_alternative.png Temple Fay gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/temple_fay/gear.scad>;
include <../../../src/temple_fay/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Standalone and pair views share this extreme butterfly profile.
module _alternative_example_temple_fay(pair=false,view="gear") {
    if (pair)
        curve_gear_temple_fay_pair(.7,48,3,4.8,wing=.38,fold=.14,samples=720,phase=69.7,together_built=true,backlash=.5,clearance=0,tooth_phase=90,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_temple_fay_body(.7,48,3,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_temple_fay_mate(.7,48,3,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_temple_fay_2d(.7,48,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_temple_fay_body_2d(.7,48,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
    else
        color(example_driver_color)
            curve_gear_temple_fay(.7,48,3,4.8,wing=.38,fold=.14,tooth_phase=90,backlash=.5,clearance=0,samples=720);
}
_alternative_example_temple_fay();
