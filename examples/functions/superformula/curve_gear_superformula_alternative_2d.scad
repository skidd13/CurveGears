/***
 * @function superformula_gear_2d_alternative
 * @brief Superformula alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/superformula/curve_gear_superformula_alternative_2d.scad`](functions/superformula/curve_gear_superformula_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/superformula/curve_gear_superformula_alternative_2d.png Superformula 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_superformula_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_superformula(view="gear_2d");
