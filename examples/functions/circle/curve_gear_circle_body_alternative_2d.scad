/***
 * @function circle_body_2d_alternative
 * @brief Circle alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/circle/curve_gear_circle_body_alternative_2d.scad`](functions/circle/curve_gear_circle_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * An additional -6 mm body offset exposes how the outer contour shrinks while the 4.8 mm bore stays fixed.
 * @image ../images/functions/circle/curve_gear_circle_body_alternative_2d.png Circle 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_circle_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_circle(view="body_2d");
