/***
 * @function tanh_triad_gear_2d_alternative
 * @brief Tanh Triad alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/tanh_triad/curve_gear_tanh_triad_alternative_2d.scad`](functions/tanh_triad/curve_gear_tanh_triad_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_alternative_2d.png Tanh Triad 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_tanh_triad_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_tanh_triad(view="gear_2d");
