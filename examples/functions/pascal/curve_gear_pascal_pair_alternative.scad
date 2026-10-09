/***
 * @function pascal_curve_gear_pair_alternative
 * @brief Pascal alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/pascal/curve_gear_pascal_pair_alternative.scad`](functions/pascal/curve_gear_pascal_pair_alternative.scad)
 * Eccentricity 0.28 gives a convex egg-like outline instead of the canonical non-convex 0.60 limacon. Twenty coarse teeth emphasise the body contour. This contrasts the regular conjugate domain with the experimental dimpled case.
 * @image ../images/functions/pascal/curve_gear_pascal_pair_alternative.png Pascal pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_pascal_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_pascal(pair=true);
