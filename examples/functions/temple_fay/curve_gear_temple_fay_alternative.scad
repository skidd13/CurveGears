/***
 * @function temple_fay_curve_gear_alternative
 * @brief Temple Fay alternative: Wing 0.05 and fold 0.01 provide a distinct but collision-free alternative to the canonical 0.18/0.05 form. The two Fourier harmonics are varied within the named family, without implying a literal butterfly curve.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_alternative.scad)
 * Wing 0.05 and fold 0.01 provide a distinct but collision-free alternative to the canonical 0.18/0.05 form. The two Fourier harmonics are varied within the named family, without implying a literal butterfly curve.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_alternative.png Temple Fay gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/temple_fay/gear.scad>;
include <../../../src/temple_fay/pair.scad>;
include <../../palette.scad>;

$fn=96;
// The alternative pair and each standalone view share one collision-free alternative profile.
module _alternative_example_temple_fay(pair=false,view="gear") {
    if (pair)
        curve_gear_temple_fay_pair(.8,34,4,4.8,wing=.05,fold=.01,samples=360,phase=180,together_built=true,backlash=.5,clearance=.5,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_temple_fay_body(.8,34,4,4.8,wing=.05,fold=.01,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_temple_fay_mate(.8,34,4,4.8,wing=.05,fold=.01,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_temple_fay_2d(.8,34,4.8,wing=.05,fold=.01,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_temple_fay_body_2d(.8,34,4.8,wing=.05,fold=.01,samples=360);
    else
        color(example_driver_color)
            curve_gear_temple_fay(.8,34,4,4.8,wing=.05,fold=.01,samples=360);
}
_alternative_example_temple_fay();
