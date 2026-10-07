/***
 * @function epitrochoid_body_2d_alternative
 * @brief Epitrochoid alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_body_alternative_2d.scad`](functions/epitrochoid/curve_gear_epitrochoid_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body_alternative_2d.png Epitrochoid 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_epitrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_epitrochoid(view="body_2d");
