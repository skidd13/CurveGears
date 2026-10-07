/***
 * @function lobed_curve_gear_alternative
 * @brief Lobed alternative: Two deep lobes replace the canonical shallow four-lobed square form. Lobe count 2 and depth 0.28 show the transition to an elongated, waisted pitch curve.
 * Source: [`functions/lobed/curve_gear_lobed_alternative.scad`](functions/lobed/curve_gear_lobed_alternative.scad)
 * Two deep lobes replace the canonical shallow four-lobed square form. Lobe count 2 and depth 0.28 show the transition to an elongated, waisted pitch curve.
 * @image ../images/functions/lobed/curve_gear_lobed_alternative.png Lobed gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/lobed/gear.scad>;
include <../../../src/lobed/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_lobed(pair=false) {
    if (pair)
        curve_gear_lobed_pair(.7,48,3,4.8,lobes=2,lobe_depth=.28,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_lobed(.7,48,3,4.8,lobes=2,lobe_depth=.28,samples=360);
}
_alternative_example_lobed();
