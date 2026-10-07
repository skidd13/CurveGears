/***
 * @function temple_fay_body_2d_alternative
 * @brief Temple Fay alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_body_alternative_2d.scad`](functions/temple_fay/curve_gear_temple_fay_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_body_alternative_2d.png Temple Fay 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_temple_fay_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_temple_fay(view="body_2d");
