/***
 * @function hypotrochoid_curve_gear_alternative
 * @brief Hypotrochoid alternative: A 5:1 rolling ratio and offset 0.35 produce five-fold shaping rather than the canonical three-fold outline. The alternative changes the curve itself, not merely the pair spacing.
 * Source: [`functions/hypotrochoid/curve_gear_hypotrochoid_alternative.scad`](functions/hypotrochoid/curve_gear_hypotrochoid_alternative.scad)
 * A 5:1 rolling ratio and offset 0.35 produce five-fold shaping rather than the canonical three-fold outline. The alternative changes the curve itself, not merely the pair spacing.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_alternative.png Hypotrochoid gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/hypotrochoid/gear.scad>;
include <../../../src/hypotrochoid/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_hypotrochoid(pair=false,view="gear") {
    if (pair)
        curve_gear_hypotrochoid_pair(.5,100,3,4.8,major_ratio=5,rolling_ratio=1,offset_ratio=.35,samples=360,together_built=false,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_hypotrochoid_body(.5,100,3,4.8,major_ratio=5,rolling_ratio=1,offset_ratio=.35,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_hypotrochoid_mate(.5,100,3,4.8,major_ratio=5,rolling_ratio=1,offset_ratio=.35,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_hypotrochoid_2d(.5,100,4.8,major_ratio=5,rolling_ratio=1,offset_ratio=.35,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_hypotrochoid_body_2d(.5,100,4.8,major_ratio=5,rolling_ratio=1,offset_ratio=.35,samples=360);
    else
        color(example_driver_color)
            curve_gear_hypotrochoid(.5,100,3,4.8,major_ratio=5,rolling_ratio=1,offset_ratio=.35,samples=360);
}
_alternative_example_hypotrochoid();
