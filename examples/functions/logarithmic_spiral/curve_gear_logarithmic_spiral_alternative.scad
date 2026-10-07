/***
 * @function logarithmic_spiral_curve_gear_alternative
 * @brief Logarithmic spiral alternative: Three spiral sectors replace the canonical single return. Growth 1.22 increases the radial sweep. Returns are broad transitions without ordinary teeth, and the pair is a static reference rather than a validated conjugate transmission.
 * Source: [`functions/logarithmic_spiral/curve_gear_logarithmic_spiral_alternative.scad`](functions/logarithmic_spiral/curve_gear_logarithmic_spiral_alternative.scad)
 * Three spiral sectors replace the canonical single return. Growth 1.22 increases the radial sweep. Returns are broad transitions without ordinary teeth, and the pair is a static reference rather than a validated conjugate transmission.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_alternative.png Logarithmic spiral gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/logarithmic_spiral/gear.scad>;
include <../../../src/logarithmic_spiral/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_logarithmic_spiral(pair=false,view="gear") {
    if (pair)
        curve_gear_logarithmic_spiral_pair(.8,48,3,4.8,sectors=3,growth_rate=1.22,samples=240,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_logarithmic_spiral_body(.8,48,3,4.8,sectors=3,growth_rate=1.22,samples=240);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_logarithmic_spiral_mate(.8,48,3,4.8,sectors=3,growth_rate=1.22,samples=240);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_logarithmic_spiral_2d(.8,48,4.8,sectors=3,growth_rate=1.22,samples=240);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_logarithmic_spiral_body_2d(.8,48,4.8,sectors=3,growth_rate=1.22,samples=240);
    else
        color(example_driver_color)
            curve_gear_logarithmic_spiral(.8,48,3,4.8,sectors=3,growth_rate=1.22,samples=240);
}
_alternative_example_logarithmic_spiral();
