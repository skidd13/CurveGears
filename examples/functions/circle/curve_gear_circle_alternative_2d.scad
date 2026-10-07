/***
 * @function circle_gear_2d_alternative
 * @brief Circle alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/circle/curve_gear_circle_alternative_2d.scad`](functions/circle/curve_gear_circle_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/circle/curve_gear_circle_alternative_2d.png Circle 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_circle_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_circle(view="gear_2d");
