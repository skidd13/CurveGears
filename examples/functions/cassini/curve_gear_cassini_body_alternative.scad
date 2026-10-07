/***
 * @function cassini_body_alternative
 * @brief Cassini alternative: The contrasting family controls shown as a body.
 * Source: [`functions/cassini/curve_gear_cassini_body_alternative.scad`](functions/cassini/curve_gear_cassini_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/cassini/curve_gear_cassini_body_alternative.png Cassini body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cassini_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_cassini(view="body");
