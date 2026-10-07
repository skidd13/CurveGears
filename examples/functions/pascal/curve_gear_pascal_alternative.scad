/***
 * @function pascal_curve_gear_alternative
 * @brief Pascal alternative: Eccentricity 0.28 gives a convex egg-like outline instead of the canonical non-convex 0.60 limacon. Twenty coarse teeth emphasise the body contour. This contrasts the regular conjugate domain with the experimental dimpled case.
 * Source: [`functions/pascal/curve_gear_pascal_alternative.scad`](functions/pascal/curve_gear_pascal_alternative.scad)
 * Eccentricity 0.28 gives a convex egg-like outline instead of the canonical non-convex 0.60 limacon. Twenty coarse teeth emphasise the body contour. This contrasts the regular conjugate domain with the experimental dimpled case.
 * @image ../images/functions/pascal/curve_gear_pascal_alternative.png Pascal gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/pascal/gear.scad>;
include <../../../src/pascal/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_pascal(pair=false) {
    if (pair)
        curve_gear_pascal_pair(1.4,20,2,4.8,eccentricity=.28,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_pascal(1.4,20,2,4.8,eccentricity=.28,samples=360);
}
_alternative_example_pascal();
