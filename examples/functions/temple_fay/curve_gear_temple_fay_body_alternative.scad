/***
 * @function temple_fay_body_alternative
 * @brief Temple Fay alternative: The contrasting family controls shown as a body.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_body_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_body_alternative.png Temple Fay body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_temple_fay_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_temple_fay(view="body");
