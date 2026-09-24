/***
 * @file Main curved-gear showcase
 * @brief Show one canonical gear from every maintained family in one view.
 *
 * Each item includes the canonical main example for its family. The showcase
 * therefore follows the examples catalogue automatically; the labels are part
 * of the preview so the silhouettes can be compared without guessing.
 */
use <functions/bezier/curve_gear_bezier.scad>;
use <functions/cassini/curve_gear_cassini.scad>;
use <functions/circle/curve_gear_circle.scad>;
use <functions/ellipse/curve_gear_ellipse.scad>;
use <functions/epitrochoid/curve_gear_epitrochoid.scad>;
use <functions/fourier/curve_gear_fourier.scad>;
use <functions/hypotrochoid/curve_gear_hypotrochoid.scad>;
use <functions/lobed/curve_gear_lobed.scad>;
use <functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad>;
use <functions/pascal/curve_gear_pascal.scad>;
use <functions/superformula/curve_gear_superformula.scad>;

$fn=64;

module _showcase_label(label) {
    color("Black")
        translate([0,-29,4.5])
            linear_extrude(height=.35)
                text(label,size=5,halign="center",valign="center");
}

module _showcase_item(x,y,label,colour) {
    translate([x,y,0]) {
        color(colour) children();
        _showcase_label(label);
    }
}

_showcase_item(-120,50,"ELLIPSE","SteelBlue")
    _main_example_ellipse();
_showcase_item(-40,50,"LOBED","Crimson")
    _main_example_lobed();
_showcase_item(40,50,"SUPERFORMULA","Orange")
    _main_example_superformula();
_showcase_item(120,50,"PASCAL","Purple")
    _main_example_pascal();

_showcase_item(-120,-50,"FOURIER","Teal")
    _main_example_fourier();
_showcase_item(-40,-50,"BEZIER","DarkGreen")
    _main_example_bezier();
_showcase_item(40,-50,"LOG SPIRAL","Gold")
    _main_example_logarithmic_spiral();
_showcase_item(120,-50,"EPITROCHOID","Tomato")
    _main_example_epitrochoid();
_showcase_item(-45,-125,"CASSINI","DarkSlateBlue")
    _main_example_cassini();
_showcase_item(45,-125,"HYPOTROCHOID","IndianRed")
    _main_example_hypotrochoid();
_showcase_item(0,-175,"CIRCLE","DimGray")
    _main_example_circle();
