/***
 * @function cosine_quintic_gear_2d_alternative
 * @brief Cosine Quintic alternative: The contrasting family controls shown as a 2D gear.
 * Source: [`functions/cosine_quintic/curve_gear_cosine_quintic_alternative_2d.scad`](functions/cosine_quintic/curve_gear_cosine_quintic_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The planar view exposes the complete outline without perspective.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_alternative_2d.png Cosine Quintic 2D gear alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_cosine_quintic_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_cosine_quintic(view="gear_2d");
