/***
 * @function epitrochoid_curve_gear_alternative
 * @brief Epitrochoid alternative: A rolling ratio of 2:1 produces broad two-fold shaping instead of the canonical four-fold scallops. Offset 0.65 strengthens the excursions of the generating point.
 * Source: [`functions/epitrochoid/curve_gear_epitrochoid_alternative.scad`](functions/epitrochoid/curve_gear_epitrochoid_alternative.scad)
 * A rolling ratio of 2:1 produces broad two-fold shaping instead of the canonical four-fold scallops. Offset 0.65 strengthens the excursions of the generating point.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_alternative.png Epitrochoid gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/epitrochoid/gear.scad>;
include <../../../src/epitrochoid/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_epitrochoid(pair=false) {
    if (pair)
        curve_gear_epitrochoid_pair(.7,48,3,4.8,major_ratio=2,rolling_ratio=1,offset_ratio=.65,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else
        color(example_driver_color)
            curve_gear_epitrochoid(.7,48,3,4.8,major_ratio=2,rolling_ratio=1,offset_ratio=.65,samples=360);
}
_alternative_example_epitrochoid();
