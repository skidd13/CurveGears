/***
 * @file Tooth placement preview
 * @brief Render cached teeth placed along a sinusoidal edge of a body.
 *
 * This diagnostic deliberately uses a rectangular body with a multi-period
 * sine-wave upper edge. Teeth are displayed only on that edge, so changing
 * tangents, normals, hills, valleys and source-point spacing can be inspected
 * without the rest of a closed gear hiding the placement behaviour. The body
 * is inset beneath the source curve, while the production tooth
 * boundary is shown in full so each tooth visibly stands on the edge.
 */
include <../../src/common/curve_gears_math.scad>;

$fn=96;
modul=1.2;
tooth_number=48;
body_width=64;
body_bottom=-12;
wave_base=15;
wave_height=4;
wave_periods=3;
wave_samples=121;
half_width=body_width/2;
points=concat(
    [[-half_width,body_bottom],[half_width,body_bottom],[half_width,wave_base]],
    [for(i=[wave_samples-2:-1:1])
        let(x=-half_width+body_width*i/(wave_samples-1))
        [x,wave_base+wave_height*sin(360*wave_periods*i/(wave_samples-1))]],
    [[-half_width,wave_base]]);

arc=_cg_polyline_arc_table(points);
perimeter=arc[len(arc)-1][1];
body=_cg_canonical_body_polyline(points,arc,perimeter,_cg_dedendum(modul),false);
candidate=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,20);
placements=[for(j=[0:tooth_number-1])
    _cg_placement_result(points,arc,perimeter,body,modul,tooth_number,j,candidate,20,0,false,undef,undef)];
wave_start=arc[2][1]+modul;
wave_end=arc[len(arc)-2][1]-modul;
display_inset=1.2;
display_half_width=half_width-display_inset;
display_points=concat(
    [[-display_half_width,body_bottom+display_inset],
        [display_half_width,body_bottom+display_inset],
        [display_half_width,wave_base-display_inset]],
    [for(i=[wave_samples-2:-1:1])
        let(x=-display_half_width+2*display_half_width*i/(wave_samples-1))
        [x,wave_base+wave_height*sin(360*wave_periods*i/(wave_samples-1))-display_inset]],
    [[-display_half_width,wave_base-display_inset]]);

color("DarkSeaGreen")
    linear_extrude(height=4,convexity=4)
        polygon(display_points);

for (placement=placements)
    if (placement[0]=="placed"
        && placement[3]>wave_start
        && placement[3]<wave_end)
        color("DarkOrange")
            translate([0,0,.05])
                linear_extrude(height=4.1,convexity=4)
                    polygon(placement[6]);
