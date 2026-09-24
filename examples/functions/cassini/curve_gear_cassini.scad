/***
 * @function cassini_curve_gear
 * @brief Render a thin-waisted peanut-shaped Cassini gear.
 * Source: [`functions/cassini/curve_gear_cassini.scad`](functions/cassini/curve_gear_cassini.scad)
 * @image ../images/functions/cassini/curve_gear_cassini.png curve_gear_cassini example preview
 */
include <../../../src/cassini/gear.scad>;
$fn=64;
module _main_example_cassini() {
    curve_gear_cassini(.8,34,4,4.8,focus_ratio=.92,samples=360);
}
_main_example_cassini();
