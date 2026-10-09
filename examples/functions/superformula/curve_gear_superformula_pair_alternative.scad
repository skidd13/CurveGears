/***
 * @function superformula_curve_gear_pair_alternative
 * @brief Superformula alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/superformula/curve_gear_superformula_pair_alternative.scad`](functions/superformula/curve_gear_superformula_pair_alternative.scad)
 * A rounded square with symmetry 4 and exponents 8 replaces the canonical five-pointed star. This demonstrates the superformula's ability to change its shape class through exponents and symmetry.
 * @image ../images/functions/superformula/curve_gear_superformula_pair_alternative.png Superformula pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_superformula_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_superformula(pair=true);
