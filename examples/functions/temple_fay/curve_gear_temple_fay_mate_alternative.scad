/***
 * @function temple_fay_mate_alternative
 * @brief Temple Fay alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_mate_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_mate_alternative.png Temple Fay mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_temple_fay_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_temple_fay(view="mate");
