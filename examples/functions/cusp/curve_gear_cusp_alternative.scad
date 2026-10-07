/***
 * @function cusp_curve_gear_alternative
 * @brief Cusp alternative: A thin plate contrasts with the thick canonical gear; the bore remains 4.8 mm. The deltoid pitch law is fixed; the validated 36-tooth count is retained while thickness reveals the body structure.
 * Source: [`functions/cusp/curve_gear_cusp_alternative.scad`](functions/cusp/curve_gear_cusp_alternative.scad)
 * A thin plate contrasts with the thick canonical gear; the bore remains 4.8 mm. The deltoid pitch law is fixed; the validated 36-tooth count is retained while thickness reveals the body structure.
 * @image ../images/functions/cusp/curve_gear_cusp_alternative.png Cusp gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cusp/gear.scad>;
include <../../../src/cusp/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_cusp(pair=false) {
    if (pair)
        curve_gear_cusp_pair(1.2,36,1,4.8,samples=720,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_cusp(1.2,36,1,4.8,samples=720);
}
_alternative_example_cusp();
