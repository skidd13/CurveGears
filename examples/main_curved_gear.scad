/***
 * @file Main curved-gear showcase
 * @brief Show one canonical gear from every maintained family in one view.
 *
 * The parameters intentionally follow the former family showcase images where
 * they are valid. Each colour identifies one family; the labels are part of
 * the preview so the silhouettes can be compared without guessing.
 */
include <../src/ellipse/gear.scad>;
include <../src/lobed/gear.scad>;
include <../src/superformula/gear.scad>;
include <../src/pascal/gear.scad>;
include <../src/fourier/gear.scad>;
include <../src/bezier/gear.scad>;
include <../src/cassini/gear.scad>;
include <../src/hypotrochoid/gear.scad>;
include <../src/logarithmic_spiral/gear.scad>;
include <../src/epitrochoid/gear.scad>;

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
    curve_gear_ellipse(.8,34,4,4.8,eccentricity=.72,samples=240);
_showcase_item(-40,50,"LOBED","Crimson")
    curve_gear_lobed(.8,34,4,4.8,lobes=4,lobe_depth=.13,samples=240);
_showcase_item(40,50,"SUPERFORMULA","Orange")
    curve_gear_superformula(.5,80,4,4.8,symmetry=5,n1=.9,n2=3.4,n3=3.4,samples=240);
_showcase_item(120,50,"PASCAL","Purple")
    curve_gear_pascal(.8,34,4,4.8,eccentricity=.35,samples=240);

_showcase_item(-120,-50,"FOURIER","Teal")
    curve_gear_fourier(.8,34,4,4.8,coefficients=[[2,.10,0],[3,.04,30]],samples=240);
_showcase_item(-40,-50,"BEZIER","DarkGreen")
    curve_gear_bezier(.8,34,4,4.8,samples=240);
_showcase_item(40,-50,"LOG SPIRAL","Gold")
    curve_gear_logarithmic_spiral(.8,34,4,4.8,sectors=1,growth_rate=1.17,samples=240);
_showcase_item(120,-50,"EPITROCHOID","Tomato")
    curve_gear_epitrochoid(.8,34,4,4.8,major_ratio=3,rolling_ratio=1,offset_ratio=.35,samples=240);
_showcase_item(-45,-125,"CASSINI","DarkSlateBlue")
    curve_gear_cassini(.8,34,4,4.8,focus_ratio=.78,samples=240);
_showcase_item(45,-125,"HYPOTROCHOID","IndianRed")
    curve_gear_hypotrochoid(.8,34,4,4.8,samples=240);
