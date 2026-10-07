/***
 * @function pascal_gear_2d_alternative
 * @brief Pascal alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/pascal/curve_gear_pascal_alternative_2d.scad`](functions/pascal/curve_gear_pascal_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/pascal/curve_gear_pascal_alternative_2d.png Pascal 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_pascal_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_pascal(view="gear_2d");
