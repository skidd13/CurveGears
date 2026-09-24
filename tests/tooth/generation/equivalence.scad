include <../../../src/common/curve_gears_math.scad>
include <reference.scad>

function old_points(m,z,pa) = reference_tooth_points(m,z,pa);
for(m=[0.05,0.8,0.999999,1,2,8], z=[5,5.5,34,200], pa=[14.5,20,35]) {
    a=old_points(m,z,pa);b=_cg_tooth_polygon(m,z,pa);
    assert(len(a)==len(b),"flank sample count changed");
    for(i=[0:len(a)-1]) assert(norm(a[i]-b[i])<1e-7,"tooth coordinate drift");
    assert(abs(_cg_dedendum(m)-(m+m/6))<1e-7,"root depth drift");
    assert(abs(_cg_dedendum(m,_cg_default_clearance(m))-_cg_dedendum(m))<1e-7,"clearance default drift");
    c=_cg_tooth_polygon(m,z,pa,_cg_default_backlash(m));
    for(i=[0:len(a)-1]) assert(norm(a[i]-c[i])<1e-7,"explicit default backlash drift");
}
assert(_cg_tooth_angles(1,34,20,0.1)[3]<_cg_tooth_angles(1,34,20,0)[3],"positive backlash must thin teeth");
assert(_cg_dedendum(1,0.2)>_cg_dedendum(1,0.1),"positive clearance must deepen root");
echo("PASS: 72 tooth cases; all flank coordinates within 1e-7");

// Keep the oracle export non-empty so the regression runner can execute it as
// an ordinary OpenSCAD case while the assertions remain the actual test.
cube([0.01,0.01,0.01]);
