/***
 * @function superformula_curve_gear
 * @brief Render a Superformula gear from the documented pitch-curve family.
 * Source: [`functions/superformula/curve_gear_superformula.scad`](functions/superformula/curve_gear_superformula.scad)
 * @image ../images/functions/superformula/curve_gear_superformula.png curve_gear_superformula example preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../../src/superformula/mate.scad>;
include <../../palette.scad>;
$fn=64;
include <../../../src/superformula/pair.scad>;

module _main_example_superformula_view(view="gear") {
    if (view=="pair") {
        $fn=64;
            curve_gear_superformula_pair(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240,phase=37,backlash=.3,driver_color=example_driver_color,mate_color=example_mate_color,together_built=true);
    }
    else if  (view=="body") {
        $fn=64;
        color(example_driver_color)
            curve_gear_superformula_body(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
    }
    else if  (view=="mate") {
        $fn=64;
        color(example_mate_color)
            curve_gear_superformula_mate(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_superformula_2d(0.5, 80, 4.8, symmetry=5, n1=0.9, n2=3.4, n3=3.4, samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_superformula_body_2d(0.5, 80, 4.8, symmetry=5, n1=0.9, n2=3.4, n3=3.4, samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_superformula(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
    }
}
module _main_example_superformula() { _main_example_superformula_view(); }
_main_example_superformula();
