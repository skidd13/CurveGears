/***
 * @function superformula_curve_gear_alternative
 * @brief Superformula alternative: A rounded square with symmetry 4 and exponents 8 replaces the canonical five-pointed star. This demonstrates the superformula's ability to change its shape class through exponents and symmetry.
 * Source: [`functions/superformula/curve_gear_superformula_alternative.scad`](functions/superformula/curve_gear_superformula_alternative.scad)
 * A rounded square with symmetry 4 and exponents 8 replaces the canonical five-pointed star. This demonstrates the superformula's ability to change its shape class through exponents and symmetry.
 * @image ../images/functions/superformula/curve_gear_superformula_alternative.png Superformula gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/superformula/gear.scad>;
include <../../../src/superformula/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_superformula(pair=false) {
    if (pair)
        curve_gear_superformula_pair(.7,60,3,4.8,symmetry=4,n1=8,n2=8,n3=8,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_superformula(.7,60,3,4.8,symmetry=4,n1=8,n2=8,n3=8,samples=360);
}
_alternative_example_superformula();
