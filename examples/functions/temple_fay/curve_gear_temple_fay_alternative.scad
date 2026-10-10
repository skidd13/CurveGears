/***
 * @function temple_fay_curve_gear_alternative
 * @brief Temple Fay alternative: Wing 0.32 and fold 0.12 restore a pronounced butterfly-like standalone outline. The pair uses a reduced collision-free profile.
 * Source: [`functions/temple_fay/curve_gear_temple_fay_alternative.scad`](functions/temple_fay/curve_gear_temple_fay_alternative.scad)
 * Standalone views use wing 0.32 and fold 0.12 for a pronounced butterfly-like outline. The meshed pair retains wing 0.05 and fold 0.01, the validated collision-free fixture.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_alternative.png Temple Fay gear alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/temple_fay/gear.scad>;
include <../../../src/temple_fay/pair.scad>;
include <../../palette.scad>;

$fn=96;
// The high-amplitude standalone profile is retained for its butterfly contour;
// the pair uses the reduced profile covered by the engaged-pair fixture.
module _alternative_example_temple_fay(pair=false,view="gear") {
    if (pair)
        curve_gear_temple_fay_pair(.8,34,4,4.8,wing=.05,fold=.01,samples=360,phase=180,together_built=true,backlash=.5,clearance=.5,driver_color=example_driver_color,mate_color=example_mate_color);
    else if (view=="body")
        color(example_driver_color)
            curve_gear_temple_fay_body(.7,48,3,4.8,wing=.32,fold=.12,samples=360);
    else if (view=="mate")
        color(example_mate_color)
            curve_gear_temple_fay_mate(.7,48,3,4.8,wing=.32,fold=.12,samples=360);
    else if (view=="gear_2d")
        color(example_driver_color)
            curve_gear_temple_fay_2d(.7,48,4.8,wing=.32,fold=.12,samples=360);
    else if (view=="body_2d")
        color(example_driver_color)
            curve_gear_temple_fay_body_2d(.7,48,4.8,wing=.32,fold=.12,samples=360);
    else
        color(example_driver_color)
            curve_gear_temple_fay(.7,48,3,4.8,wing=.32,fold=.12,samples=360);
}
_alternative_example_temple_fay();
