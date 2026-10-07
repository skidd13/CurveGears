/***
 * @function fourier_curve_gear_alternative
 * @brief Fourier alternative: A single strong third harmonic produces three clear lobes instead of the canonical mixed second/third-harmonic oval. This isolates harmonic count from mixed-phase asymmetry.
 * Source: [`functions/fourier/curve_gear_fourier_alternative.scad`](functions/fourier/curve_gear_fourier_alternative.scad)
 * A single strong third harmonic produces three clear lobes instead of the canonical mixed second/third-harmonic oval. This isolates harmonic count from mixed-phase asymmetry.
 * @image ../images/functions/fourier/curve_gear_fourier_alternative.png Fourier gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/fourier/gear.scad>;
include <../../../src/fourier/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_fourier(pair=false,view="gear") {
    if (pair)
        curve_gear_fourier_pair(.7,60,3,4.8,coefficients=[[3,.24,0]],samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_fourier_body(.7,60,3,4.8,coefficients=[[3,.24,0]],samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_fourier_mate(.7,60,3,4.8,coefficients=[[3,.24,0]],samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_fourier_2d(.7,60,4.8,coefficients=[[3,.24,0]],samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_fourier_body_2d(.7,60,4.8,coefficients=[[3,.24,0]],samples=360);
    else
        color(example_driver_color)
            curve_gear_fourier(.7,60,3,4.8,coefficients=[[3,.24,0]],samples=360);
}
_alternative_example_fourier();
