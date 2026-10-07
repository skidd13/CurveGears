/***
 * @function tooth_assembly
 * @brief Tooth assembly preview: Compare placed tooth boundaries with the final assembled outline.
 * Source: [`tooth/assembly.scad`](tooth/assembly.scad)
 *
 * The left panel keeps the canonical body and accepted placed tooth
 * boundaries separate. The right panel is the single outline returned by
 * _cg_final_outline_from_placements, so the body intervals replaced by teeth
 * can be checked as one continuous polygon.
 * @image ../images/tooth/assembly.png Tooth assembly 1
 * @image ../images/tooth/assembly_alternative.png Tooth assembly 2
 */
include <../../src/common/curve_gears_math.scad>;
include <../palette.scad>;
include <palette.scad>;

$fn=96;
module _example_tooth_assembly(modul=.8,tooth_number=34,width=4,samples=160,panel_offset=22,aspect=1) {
    pitch_radius=modul*tooth_number/2;
    unit_points=[for(i=[0:samples-1]) [cos(360*i/samples),aspect*sin(360*i/samples)]];
    points=aspect==1 ? [for(i=[0:samples-1])
        [pitch_radius*cos(360*i/samples),pitch_radius*sin(360*i/samples)]]
        : _cg_scale_points(_cg_pitch_scale_from_points(modul,tooth_number,unit_points,_cg_pi),unit_points);
    arc=_cg_polyline_arc_table(points);
    perimeter=arc[len(arc)-1][1];
    body=_cg_canonical_body_polyline(points,_cg_dedendum(modul),false);
    candidate=_cg_reference_tooth_candidate(pitch_radius,modul,tooth_number,20);
    placements=[for(j=[0:tooth_number-1])
        _cg_placement_result(points,arc,perimeter,body,modul,tooth_number,j,candidate,20,0,false,undef,undef)];
    selected=[for(placement=placements) if(placement[0]=="placed") placement];
    assert(len(selected)==tooth_number,str("assembly showcase expected all teeth placed, got ",len(selected)));
    assembled=_cg_final_outline_from_placements(body,arc,perimeter,selected);

    translate([-panel_offset,0,0]) {
        color(example_driver_color)
            linear_extrude(height=width,convexity=4)
                polygon(body);
        for(placement=selected)
            color(example_tooth_color)
                translate([0,0,.05])
                    linear_extrude(height=width+.1,convexity=4)
                        polygon(placement[6]);
        color("DimGray")
            translate([0,-pitch_radius-9,width+.1])
                linear_extrude(height=.02)
                    text("PLACED",size=3.5,halign="center",valign="center");
    }

    translate([panel_offset,0,0]) {
        color(example_driver_color)
            linear_extrude(height=width,convexity=4)
                polygon(assembled);
        color("DimGray")
            translate([0,-pitch_radius-9,width+.1])
                linear_extrude(height=.02)
                    text("ASSEMBLED",size=3.5,halign="center",valign="center");
    }
}
_example_tooth_assembly();
