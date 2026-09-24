/***
 * @function mate_phase_forwarding
 * @brief Verify that mate tooth phase reaches the shared placement engine.
 * @return {geometry} Small validation solid.
 */
include <../../src/common/curve_gears_math.scad>

samples=240;
modul=.8;
tooth_number=34;
points=[for(i=[0:samples-1]) [10*cos(360*i/samples),10*sin(360*i/samples)]];
arc=_cg_polyline_arc_table(points);
perimeter=arc[len(arc)-1][1];
body=_cg_canonical_body_polyline(points,arc,perimeter,_cg_dedendum(modul));
candidate=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,20);
zero=_cg_placement_result(points,arc,perimeter,body,modul,tooth_number,7,candidate,20,0,false,undef,undef);
phased=_cg_placement_result(points,arc,perimeter,body,modul,tooth_number,7,candidate,20,90,false,undef,undef);

assert(zero[0]=="placed" && phased[0]=="placed","phase forwarding fixture could not place both teeth");
assert(abs(zero[3]-phased[3])>1e-6,
    "non-zero tooth phase did not change the placement target");
assert(abs(_cg_vlen(zero[4][0])-_cg_vlen(phased[4][0]))<.01,
    "tooth phase changed the reference pitch radius");
echo("stage=mate severity=info code=TOOTH_PHASE_FORWARDING PASS");
cube([.01,.01,.01]);
