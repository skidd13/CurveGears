/***
 * @function cassini_curve_gear_alternative
 * @brief Cassini alternative: A low focus ratio of 0.35 produces a compact oval rather than the canonical 0.92 peanut waist. Twenty coarse teeth make the limiting near-circular form clear.
 * Source: [`functions/cassini/curve_gear_cassini_alternative.scad`](functions/cassini/curve_gear_cassini_alternative.scad)
 * A low focus ratio of 0.35 produces a compact oval rather than the canonical 0.92 peanut waist. Twenty coarse teeth make the limiting near-circular form clear.
 * @image ../images/functions/cassini/curve_gear_cassini_alternative.png Cassini gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/cassini/gear.scad>;
include <../../../src/cassini/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_cassini(pair=false,view="gear") {
    if (pair)
        curve_gear_cassini_pair(1,20,2,4.8,focus_ratio=.35,samples=360,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_cassini_body(1,20,2,4.8,focus_ratio=.35,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_cassini_mate(1,20,2,4.8,focus_ratio=.35,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_cassini_2d(1,20,4.8,focus_ratio=.35,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_cassini_body_2d(1,20,4.8,focus_ratio=.35,samples=360);
    else
        color(example_driver_color)
            curve_gear_cassini(1,20,2,4.8,focus_ratio=.35,samples=360);
}
_alternative_example_cassini();
