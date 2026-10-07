/***
 * @function cusp_mate_alternative
 * @brief Cusp alternative: The contrasting family controls shown as a mate.
 * Source: [`functions/cusp/curve_gear_cusp_mate_alternative.scad`](functions/cusp/curve_gear_cusp_mate_alternative.scad)
 * This uses the same curve, tooth scale and bore as the family gear alternative.
 * The mate uses copper; it retains the reference-pair limitations documented for this family.
 * @image ../images/functions/cusp/curve_gear_cusp_mate_alternative.png Cusp mate alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cusp_alternative.scad>;
include <../../palette.scad>;
$fn=0; // Match the canonical view tessellation.
_alternative_example_cusp(view="mate");
