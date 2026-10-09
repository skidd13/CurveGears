/***
 * @function cassini_curve_gear_pair_alternative
 * @brief Cassini alternative pair: The alternative curve and its mate meshed in contact for inspection.
 * Source: [`functions/cassini/curve_gear_cassini_pair_alternative.scad`](functions/cassini/curve_gear_cassini_pair_alternative.scad)
 * A low focus ratio of 0.35 produces a compact oval rather than the canonical 0.92 peanut waist. Twenty coarse teeth make the limiting near-circular form clear.
 * @image ../images/functions/cassini/curve_gear_cassini_pair_alternative.png Cassini pair alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <curve_gear_cassini_alternative.scad>;
include <../../palette.scad>;
$fn=96;
_alternative_example_cassini(pair=true);
