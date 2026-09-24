/***
 * @function common_ordinary_variants
 * @brief Ordinary circular cases covering more than one module/tooth-count pair.
 * Source: [`common/ordinary_variants.scad`](common/ordinary_variants.scad)
 */
include <../../src/common/curve_gears_math.scad>

$fn=96;

module ordinary_case(modul,tooth_number,bore,centre_x) {
    pitch_radius=modul*tooth_number/2;
    samples=max(96,tooth_number*8);
    points=[for(i=[0:samples-1])
        [pitch_radius*cos(360*i/samples),pitch_radius*sin(360*i/samples)]];
    translate([centre_x,0,0])
        _cg_gear_from_pitch_points(points,modul,tooth_number,4,bore,20,0,false,undef,undef,false);
}

ordinary_case(.5,8,1.2,-12);
ordinary_case(1.2,12,3.6,12);
