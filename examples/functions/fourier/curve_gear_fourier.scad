/***
 * @function fourier_curve_gear
 * @brief Render a two-harmonic Fourier gear with visibly modulated lobes.
 * Source: [`functions/fourier/curve_gear_fourier.scad`](functions/fourier/curve_gear_fourier.scad)
 * @image ../images/functions/fourier/curve_gear_fourier.png curve_gear_fourier example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/fourier/mate.scad>;
include <../../../src/fourier/pair.scad>;
include <../../palette.scad>;
$fn=64;
module _main_example_fourier_view(view="gear") {
    if (view=="pair") {
        $fn=64;
        curve_gear_fourier_pair(.8,34,4,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240,phase=37,backlash=.15,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_fourier_body(.8,34,4,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
    }
    else if (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_fourier_mate(.8,34,4,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
    }
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_fourier_2d(.8,34,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_fourier_body_2d(.8,34,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_fourier(.8,34,4,4.8,coefficients=[[2,.22,0],[3,.08,30]],samples=240);
    }
}
module _main_example_fourier() { _main_example_fourier_view(); }
_main_example_fourier();
