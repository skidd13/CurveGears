/***
 * @function ellipse_gear_2d_alternative
 * @brief Ellipse alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/ellipse/curve_gear_ellipse_alternative_2d.scad`](functions/ellipse/curve_gear_ellipse_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/ellipse/curve_gear_ellipse_alternative_2d.png Ellipse 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_ellipse_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_ellipse(view="gear_2d");
