/***
 * @function hypotrochoid_gear_2d_alternative
 * @brief Hypotrochoid alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_alternative_2d.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_alternative_2d.png Hypotrochoid 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_hypotrochoid_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_hypotrochoid(view="gear_2d");
