/***
 * @function epitrochoid_body_alternative
 * @brief Epitrochoid alternative: The contrasting family controls shown as a body.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_body_alternative.scad`](functions/epitrochoid/curve_gear_epitrochoid_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body_alternative.png Epitrochoid body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_epitrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_epitrochoid(view="body");
