/***
 * @file Main curved-gear showcase
 * @brief Show one canonical gear from every maintained family in one view.
 *
 * Each item includes the canonical main example for its family. The showcase
 * therefore follows the examples catalogue automatically; the labels are part
 * of the preview so the silhouettes can be compared without guessing.
 * The maintained families are arranged in a compact four-column grid.
 */
use <functions/bezier/curve_gear_bezier.scad>;
use <functions/cassini/curve_gear_cassini.scad>;
use <functions/circle/curve_gear_circle.scad>;
use <functions/cosine_quintic/curve_gear_cosine_quintic.scad>;
use <functions/cusp/curve_gear_cusp.scad>;
use <functions/ellipse/curve_gear_ellipse.scad>;
use <functions/epitrochoid/curve_gear_epitrochoid.scad>;
use <functions/fourier/curve_gear_fourier.scad>;
use <functions/hypotrochoid/curve_gear_hypotrochoid.scad>;
use <functions/lobed/curve_gear_lobed.scad>;
use <functions/logarithmic_spiral/curve_gear_logarithmic_spiral.scad>;
use <functions/logistic_dwell/curve_gear_logistic_dwell.scad>;
use <functions/pascal/curve_gear_pascal.scad>;
use <functions/superformula/curve_gear_superformula.scad>;
use <functions/tanh_triad/curve_gear_tanh_triad.scad>;
use <functions/temple_fay/curve_gear_temple_fay.scad>;

$fn=64;

module _showcase_label(label) {
    color("Black")
        translate([0,-38,5])
            linear_extrude(height=.35)
                text(label,size=3.2,halign="center",valign="center");
}

module _showcase_item(x,y,label,colour) {
    translate([x,y,0]) {
        scale([1,1,1]) color(colour) children();
        _showcase_label(label);
    }
}

// Alphabetical family order, arranged as a centred four-column grid.
_showcase_item(-82.5,120,"BEZIER","DarkGreen")
    _main_example_bezier();
_showcase_item(-27.5,120,"CASSINI","DarkSlateBlue")
    _main_example_cassini();
_showcase_item(27.5,120,"CIRCLE","DimGray")
    _main_example_circle();
_showcase_item(82.5,120,"CUSP","DarkOrange")
    _main_example_cusp();
_showcase_item(-82.5,40,"ELLIPSE","SteelBlue")
    _main_example_ellipse();
_showcase_item(-27.5,40,"EPITROCHOID","Tomato")
    _main_example_epitrochoid();
_showcase_item(27.5,40,"FOURIER","Teal")
    _main_example_fourier();
_showcase_item(82.5,40,"HYPOTROCHOID","IndianRed")
    _main_example_hypotrochoid();
_showcase_item(-82.5,-40,"LOBED","Crimson")
    _main_example_lobed();
_showcase_item(-27.5,-40,"LOG SPIRAL","Gold")
    _main_example_logarithmic_spiral();
_showcase_item(27.5,-40,"LOGISTIC DWELL","DarkViolet")
    _main_example_logistic_dwell();
_showcase_item(82.5,-40,"PASCAL","Purple")
    _main_example_pascal();
_showcase_item(-82.5,-120,"SUPERFORMULA","Orange")
    _main_example_superformula();
_showcase_item(-27.5,-120,"TANH TRIAD","SeaGreen")
    _main_example_tanh_triad();
_showcase_item(27.5,-120,"TEMPLE FAY","HotPink")
    _main_example_temple_fay();
_showcase_item(82.5,-120,"COSINE QUINTIC","RoyalBlue")
    _main_example_cosine_quintic();
