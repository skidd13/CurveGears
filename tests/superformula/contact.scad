/***
 * @function superformula_contact
 * @brief Verify Superformula contact geometry and pitch diagnostics.
 * Source: [`superformula/contact.scad`](superformula/contact.scad)
 */
include <../../src/superformula/pair.scad>

function _test_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n) =
    [for(i=[0:n-1]) _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,360*(i+.5)/n)];
function _test_superformula_driver_radii(scale,symmetry,a,b,n1,n2,n3,n) =
    [for(i=[0:n-1]) _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,360*i/n)];
function _test_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,n) =
    let(mx=_cg_superformula_max_radius(scale,symmetry,a,b,n1,n2,n3,720),mid=_test_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n))
    _cg_solve_mate_distance(mid,mx+.01,4*mx);

phase=is_undef(test_phase) ? 0 : test_phase;
modul=.5;
tooth_number=80;
width=1;
bore=4.8;
symmetry=5;
n1=.9;
n2=3.4;
n3=3.4;
samples=360;
scale=_cg_superformula_scale(modul,tooth_number,symmetry,1,1,n1,n2,n3,360);
D=_test_superformula_centre_distance(scale,symmetry,1,1,n1,n2,n3,samples);
motion=_cg_motion_table_from_mid_radii(_test_superformula_motion_radii(scale,symmetry,1,1,n1,n2,n3,samples),D);
driver=_cg_superformula_points(scale,symmetry,1,1,n1,n2,n3,samples);
mate=_cg_mate_points_from_radius_samples(_test_superformula_driver_radii(scale,symmetry,1,1,n1,n2,n3,samples),_test_superformula_motion_radii(scale,symmetry,1,1,n1,n2,n3,samples),D);
A=D;

intersection() {
    translate([-A/2,0,0]) rotate([0,0,phase])
        _cg_gear_from_pitch_points(driver,modul,tooth_number,width,bore,20,0);
    translate([A/2,0,0]) rotate([0,0,_cg_mate_rotation_for_phase(motion,phase)])
        _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,20);
}
