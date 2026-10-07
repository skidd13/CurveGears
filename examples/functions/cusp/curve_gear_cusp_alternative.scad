/***
 * @function cusp_curve_gear_alternative
 * @brief Cusp alternative: Five cusps replace the canonical three-cusp deltoid. With 60 tooth positions, each cusp sector retains twelve tooth positions; the bore remains 4.8 mm. Set `cusps=5` and keep tooth count and samples divisible by five.
 * Source: [`functions/cusp/curve_gear_cusp_alternative.scad`](functions/cusp/curve_gear_cusp_alternative.scad)
 * Five cusps replace the canonical three-cusp deltoid. With 60 tooth positions, each cusp sector retains twelve tooth positions; the bore remains 4.8 mm. Set `cusps=5` and keep tooth count and samples divisible by five.
 * @image ../images/functions/cusp/curve_gear_cusp_alternative.png Cusp gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cusp/gear.scad>;
include <../../../src/cusp/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share these independent size and shape controls.
// Change tooth_number by any multiple of cusps; modul controls pitch size.
// Samples must also be a multiple of cusps. Width is extrusion thickness.
module _alternative_example_cusp(pair=false,cusps=5,tooth_number=60,width=4,bore=4.8,modul=.8,samples=720) {
    assert(tooth_number%cusps==0,"example: tooth_number must be divisible by cusps");
    if (pair)
        curve_gear_cusp_pair(modul,tooth_number,width,bore,samples=samples,cusps=cusps,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_cusp(modul,tooth_number,width,bore,samples=samples,cusps=cusps);
}
_alternative_example_cusp();
