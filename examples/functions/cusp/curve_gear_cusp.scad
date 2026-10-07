/**
 * @function cusp_curve_gear
 * @brief Render the three-cusp gear with radial teeth whose roots follow the cusp branches.
 * Source: [`cusp/curve_gear_cusp.scad`](cusp/curve_gear_cusp.scad)
 */
use <../../../src/cusp/gear.scad>
include <../../palette.scad>;
$fn=64;
module _main_example_cusp() {
    curve_gear_cusp(.8,36,4,4.8,samples=720);
}
color(example_driver_color)
_main_example_cusp();
