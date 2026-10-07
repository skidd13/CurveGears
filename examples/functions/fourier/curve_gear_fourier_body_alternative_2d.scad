/***
 * @function fourier_body_2d_alternative
 * @brief Fourier alternative: The contrasting family controls shown as a 2D body.
 * Source: [`functions/fourier/curve_gear_fourier_body_alternative_2d.scad`](functions/fourier/curve_gear_fourier_body_alternative_2d.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/fourier/curve_gear_fourier_body_alternative_2d.png Fourier 2D body alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <curve_gear_fourier_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_fourier(view="body_2d");
