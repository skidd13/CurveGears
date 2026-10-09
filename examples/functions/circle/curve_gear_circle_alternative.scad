/***
 * @function circle_curve_gear_alternative
 * @brief Circle alternative: Twelve coarse teeth replace the fine-toothed reference; the bore remains 4.8 mm. Circle has no non-circular shape control; the circular pitch law is deliberately preserved.
 * Source: [`functions/circle/curve_gear_circle_alternative.scad`](functions/circle/curve_gear_circle_alternative.scad)
 * Twelve coarse teeth replace the fine-toothed reference; the bore remains 4.8 mm. Circle has no non-circular shape control; the circular pitch law is deliberately preserved.
 * @image ../images/functions/circle/curve_gear_circle_alternative.png Circle gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/circle/gear.scad>;
include <../../../src/circle/pair.scad>;
include <../../palette.scad>;

$fn=96;
// Both executable alternatives share this parameter source.
module _alternative_example_circle(pair=false,view="gear") {
    if (pair)
        curve_gear_circle_pair(2,12,2,4.8,samples=360,together_built=true,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_circle_body(2,12,2,4.8,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_circle_mate(2,12,2,4.8,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_circle_2d(2,12,4.8,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_circle_body_2d(2,12,4.8,samples=360,body_offset=-6);
    else
        color(example_driver_color)
            curve_gear_circle(2,12,2,4.8,samples=360);
}
_alternative_example_circle();
