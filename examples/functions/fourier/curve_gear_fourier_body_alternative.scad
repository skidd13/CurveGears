/***
 * @function fourier_body_alternative
 * @brief Fourier alternative: The contrasting family controls shown as a body.
 * Source: [`functions/fourier/curve_gear_fourier_body_alternative.scad`](functions/fourier/curve_gear_fourier_body_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The body view exposes the contour before ordinary tooth placement.
 * @image ../images/functions/fourier/curve_gear_fourier_body_alternative.png Fourier body alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_fourier_alternative.scad>;
include <../../palette.scad>;
$fn=64; // Match the canonical view tessellation.
_alternative_example_fourier(view="body");
