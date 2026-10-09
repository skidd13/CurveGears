/***
 * @function ellipse_curve_gear_pair_alternative
 * @brief Ellipse alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/ellipse/curve_gear_ellipse_pair_alternative.scad`](functions/ellipse/curve_gear_ellipse_pair_alternative.scad)
 * Eccentricity 0.85 produces a long ellipse rather than the canonical 0.72 oval while retaining a validated engaged pair.
 * @image ../images/functions/ellipse/curve_gear_ellipse_pair_alternative.png Ellipse pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_ellipse_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_ellipse(pair=true);
