/***
 * @file Tooth assembly preview
 * @brief Compare placed tooth boundaries with the final assembled outline.
 *
 * The left panel keeps the canonical body and accepted placed tooth
 * boundaries separate. The right panel is the single outline returned by
 * _cg_final_outline_from_placements, so the body intervals replaced by teeth
 * can be checked as one continuous polygon.
 */
include <../../src/common/curve_gears_math.scad>;

$fn=96;
modul=.8;
tooth_number=34;
width=4;
samples=160;
pitch_radius=modul*tooth_number/2;
panel_offset=22;
points=[for(i=[0:samples-1])
    [pitch_radius*cos(360*i/samples),pitch_radius*sin(360*i/samples)]];
arc=_cg_polyline_arc_table(points);
perimeter=arc[len(arc)-1][1];
body=_cg_canonical_body_polyline(points,arc,perimeter,_cg_dedendum(modul),false);
candidate=_cg_reference_tooth_candidate(pitch_radius,modul,tooth_number,20);
placements=[for(j=[0:tooth_number-1])
    _cg_placement_result(points,arc,perimeter,body,modul,tooth_number,j,candidate,20,0,false,undef,undef)];
selected=[for(placement=placements) if(placement[0]=="placed") placement];
assert(len(selected)==tooth_number,str("assembly showcase expected all teeth placed, got ",len(selected)));
assembled=_cg_final_outline_from_placements(body,arc,perimeter,selected);

translate([-panel_offset,0,0]) {
    color("DarkSeaGreen")
        linear_extrude(height=width,convexity=4)
            polygon(body);
    for(placement=selected)
        color("DarkOrange")
            translate([0,0,.05])
                linear_extrude(height=width+.1,convexity=4)
                    polygon(placement[6]);
    color("DimGray")
        translate([0,-pitch_radius-9,width+.1])
            linear_extrude(height=.02)
                text("PLACED",size=3.5,halign="center",valign="center");
}

translate([panel_offset,0,0]) {
    color("SteelBlue")
        linear_extrude(height=width,convexity=4)
            polygon(assembled);
    color("DimGray")
        translate([0,-pitch_radius-9,width+.1])
            linear_extrude(height=.02)
                text("ASSEMBLED",size=3.5,halign="center",valign="center");
}
