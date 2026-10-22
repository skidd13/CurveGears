/***
 * @function temple_fay_curve_gear_alternative
 * @brief Temple Fay alternative with a narrower waist and more compact lobes.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_alternative.scad)
 * All alternative views use wing 0.18 and fold 0.05 for a restrained outline.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_alternative.png Temple Fay gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/temple_fay/gear.scad>;
include <../../../src/temple_fay/pair.scad>;
include <../../palette.scad>;

module _alternative_example_temple_fay(pair=false,view="gear") {
    if (pair)
        curve_gear_temple_fay_pair(.8,34,4,4.8,wing=.18,fold=.05,samples=240,phase=64,together_built=true,backlash=.5,clearance=.5,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_temple_fay_body(.8,34,4,4.8,wing=.18,fold=.05,samples=240);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_temple_fay_mate(.8,34,4,4.8,wing=.18,fold=.05,samples=240);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_temple_fay_2d(.8,34,4.8,wing=.18,fold=.05,samples=240);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_temple_fay_body_2d(.8,34,4.8,wing=.18,fold=.05,samples=240);
    else
        color(example_driver_color)
            curve_gear_temple_fay(.8,34,4,4.8,wing=.18,fold=.05,samples=240);
}
_alternative_example_temple_fay();
