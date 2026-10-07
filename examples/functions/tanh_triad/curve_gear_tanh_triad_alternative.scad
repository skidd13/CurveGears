/***
 * @function tanh_triad_curve_gear_alternative
 * @brief Tanh Triad alternative: A broad smooth triad with transition 0.8 and crest 0.32 replaces the canonical sharper, corrected triad. Removing the sixth-harmonic correction isolates the three-lobed tanh law; coarse teeth expose its boundary.
 * Source: [`functions/tanh_triad/curve_gear_tanh_triad_alternative.scad`](functions/tanh_triad/curve_gear_tanh_triad_alternative.scad)
 * A broad smooth triad with transition 0.8 and crest 0.32 replaces the canonical sharper, corrected triad. Removing the sixth-harmonic correction isolates the three-lobed tanh law; coarse teeth expose its boundary.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_alternative.png Tanh Triad gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/tanh_triad/gear.scad>;
include <../../../src/tanh_triad/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_tanh_triad(pair=false) {
    if (pair)
        curve_gear_tanh_triad_pair(1.2,24,2,4.8,transition=.8,crest=.32,correction=0,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_tanh_triad(1.2,24,2,4.8,transition=.8,crest=.32,correction=0,samples=360);
}
_alternative_example_tanh_triad();
