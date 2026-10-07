/***
 * @function cosine_quintic_curve_gear_alternative
 * @brief Cosine Quintic alternative: Three pronounced signed-cosine plateaux replace the canonical two-harmonic form. Harmonic 3 and depth 0.16 expose how the fifth power concentrates the radial excursions.
 * Source: [`functions/cosine_quintic/curve_gear_cosine_quintic_alternative.scad`](functions/cosine_quintic/curve_gear_cosine_quintic_alternative.scad)
 * Three pronounced signed-cosine plateaux replace the canonical two-harmonic form. Harmonic 3 and depth 0.16 expose how the fifth power concentrates the radial excursions.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_alternative.png Cosine Quintic gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cosine_quintic/gear.scad>;
include <../../../src/cosine_quintic/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_cosine_quintic(pair=false) {
    if (pair)
        curve_gear_cosine_quintic_pair(.5,96,3,4.8,depth=.16,harmonic=3,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_cosine_quintic(.5,96,3,4.8,depth=.16,harmonic=3,samples=360);
}
_alternative_example_cosine_quintic();
