/***
 * @function temple_fay_curve_gear_alternative
 * @brief Temple Fay alternative: Wing 0.32 and fold 0.12 strengthen the diagonal wing and waist structure compared with the canonical 0.18/0.05 form. The two Fourier harmonics are varied within the named family, without implying a literal butterfly curve.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_alternative.scad)
 * Wing 0.32 and fold 0.12 strengthen the diagonal wing and waist structure compared with the canonical 0.18/0.05 form. The two Fourier harmonics are varied within the named family, without implying a literal butterfly curve.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_alternative.png Temple Fay gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/temple_fay/gear.scad>;
include <../../../src/temple_fay/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_temple_fay(pair=false) {
    if (pair)
        curve_gear_temple_fay_pair(.7,48,3,4.8,wing=.32,fold=.12,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_temple_fay(.7,48,3,4.8,wing=.32,fold=.12,samples=360);
}
_alternative_example_temple_fay();
