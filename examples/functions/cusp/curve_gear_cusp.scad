/**
 * @function cusp_curve_gear
 * @brief Render the three-cusp gear with radial teeth whose roots follow the cusp branches.
 * Source: [`cusp/curve_gear_cusp.scad`](cusp/curve_gear_cusp.scad)
  * @image ../images/functions/cusp/curve_gear_cusp.png cusp example preview
*/
use <../../../src/cusp/gear.scad>
include <../../palette.scad>;
$fn=64;
include <../../../src/cusp/pair.scad>;

module _main_example_cusp_view(view="gear") {
    if (view=="pair") {
            curve_gear_cusp_pair(1.2,36,4,4.8,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if  (view=="body") {
        color(example_driver_color)
            curve_gear_cusp_body(1.2,36,4,4.8);
    }
    else if  (view=="mate") {
        color(example_mate_color)
            curve_gear_cusp_mate(1.2,36,4,4.8);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_cusp_2d(0.8, 36, 4.8, samples=720);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_cusp_body_2d(0.8, 36, 4.8, samples=720);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_cusp(.8,36,4,4.8,samples=720);
    }
}
module _main_example_cusp() { _main_example_cusp_view(); }
_main_example_cusp();
