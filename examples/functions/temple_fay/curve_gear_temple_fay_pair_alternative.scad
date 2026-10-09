/***
 * @function temple_fay_curve_gear_pair_alternative
 * @brief Temple Fay alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_pair_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_pair_alternative.scad)
 * Wing 0.32 and fold 0.12 strengthen the diagonal wing and waist structure compared with the canonical 0.18/0.05 form. The two Fourier harmonics are varied within the named family, without implying a literal butterfly curve.
 * The contact-pair fixture uses the same bore and width with a reduced .08/.02 wing/fold profile so the engaged mate remains collision-free.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_pair_alternative.png Temple Fay pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_temple_fay_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_temple_fay(pair=true);
