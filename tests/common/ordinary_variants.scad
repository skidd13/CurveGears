/***
 * @function common_ordinary_variants
 * @brief Ordinary circular cases covering more than one module/tooth-count pair.
 * Source: [`common/ordinary_variants.scad`](common/ordinary_variants.scad)
 */
include <../../src/common/curve_gears_math.scad>

$fn=96;

sampled_square=[[1,0],[0,1],[-1,0],[0,-1]];
sampled_square_perimeter=_cg_closed_polyline_perimeter(sampled_square);
assert(abs(sampled_square_perimeter-4*sqrt(2))<1e-12,"common sampled perimeter mismatch");
assert(_cg_scale_points(2,sampled_square)==[[2,0],[0,2],[-2,0],[0,-2]],"common point scaling mismatch");
assert(abs(_cg_pitch_scale_from_points(2,8,sampled_square,_cg_circle_pi)-_cg_circle_pi*16/sampled_square_perimeter)<1e-12,
    "common pitch scale must use the supplied circumference constant");
sampled_square_arc=_cg_polyline_arc_table(sampled_square);
function _cg_reference_body_interval(body,arc,perimeter,start_s,end_s) =
    let(wrapped_start=start_s-perimeter*floor(start_s/perimeter),
        start_u=_cg_interp_x_for_y(arc,wrapped_start),
        start_index=min(len(body)-1,max(0,floor(start_u))))
    [for(q=[0:len(body)-1])
        let(k=(start_index+1+q)%len(body),base=arc[k][1],
            shifted=base+perimeter*ceil((start_s-base+_cg_eps_len())/perimeter))
        if(shifted>start_s+_cg_eps_len() && shifted<end_s-_cg_eps_len())
            _cg_point_for_closed_arc(body,arc,shifted)];
assert(_cg_body_interval_before(sampled_square,sampled_square_arc,sampled_square_perimeter,
    .1*sampled_square_perimeter,.6*sampled_square_perimeter)
    ==_cg_reference_body_interval(sampled_square,sampled_square_arc,sampled_square_perimeter,
    .1*sampled_square_perimeter,.6*sampled_square_perimeter),"body interval changed within one turn");
assert(_cg_body_interval_before(sampled_square,sampled_square_arc,sampled_square_perimeter,
    .8*sampled_square_perimeter,1.2*sampled_square_perimeter)
    ==_cg_reference_body_interval(sampled_square,sampled_square_arc,sampled_square_perimeter,
    .8*sampled_square_perimeter,1.2*sampled_square_perimeter),"body interval changed across the seam");
assert(_cg_body_interval_before(sampled_square,sampled_square_arc,sampled_square_perimeter,
    -.2*sampled_square_perimeter,.2*sampled_square_perimeter)
    ==_cg_reference_body_interval(sampled_square,sampled_square_arc,sampled_square_perimeter,
    -.2*sampled_square_perimeter,.2*sampled_square_perimeter),"negative body interval changed across the seam");
assert(_cg_body_interval_before(sampled_square,sampled_square_arc,sampled_square_perimeter,
    0,sampled_square_perimeter)
    ==_cg_reference_body_interval(sampled_square,sampled_square_arc,sampled_square_perimeter,
    0,sampled_square_perimeter),"full-turn body interval changed");
duplicate_edge_case=[[0,0],[1,0],[1,1],[1+5e-8,0],[5e-8,0]];
assert(_cg_has_duplicate_edge(duplicate_edge_case),"duplicate-edge broad phase missed endpoints within tolerance");
assert(!_cg_has_duplicate_edge(sampled_square),"duplicate-edge broad phase rejected a simple closed contour");

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
