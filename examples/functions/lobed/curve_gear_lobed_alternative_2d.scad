/***
 * @function lobed_gear_2d_alternative
 * @brief Lobed alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/lobed/curve_gear_lobed_alternative_2d.scad`](functions/lobed/curve_gear_lobed_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/lobed/curve_gear_lobed_alternative_2d.png Lobed 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_lobed_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_lobed(view="gear_2d");
