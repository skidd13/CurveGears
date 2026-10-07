/***
 * @function circle_body_alternative
 * @brief Circle alternative: The contrasting family controls shown as a body.
 * Source: [`functions/circle/curve_gear_circle_body_alternative.scad`](functions/circle/curve_gear_circle_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * A 0.5 mm plate contrasts with the thick canonical body while retaining the 4.8 mm bore.
 * @image ../images/functions/circle/curve_gear_circle_body_alternative.png Circle body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_circle_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_circle(view="body");
