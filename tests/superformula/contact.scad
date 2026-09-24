/***
 * @function superformula_contact
 * @brief Verify Superformula contact geometry and pitch diagnostics.
 * Source: [`superformula/contact.scad`](superformula/contact.scad)
 */
include <../../src/superformula/pair.scad>

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
D=_cg_superformula_centre_distance(scale,symmetry,1,1,n1,n2,n3);
motion=_cg_superformula_motion_table(scale,symmetry,1,1,n1,n2,n3,D,samples);
driver=_cg_superformula_points(scale,symmetry,1,1,n1,n2,n3,samples);
mate=[for(i=[0:samples-1]) _cg_superformula_mate_point(scale,symmetry,1,1,n1,n2,n3,D,motion,360*i/samples)];
A=D;

intersection() {
    translate([-A/2,0,0]) rotate([0,0,phase])
        _cg_gear_from_pitch_points(driver,modul,tooth_number,width,bore,20,0);
    translate([A/2,0,0]) rotate([0,0,_cg_mate_rotation_for_phase(motion,phase)])
        _cg_mate_boundary_from_pitch_points(mate,modul,tooth_number,width,bore,20);
}
