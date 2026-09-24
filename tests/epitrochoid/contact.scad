include <../../src/epitrochoid/pair.scad>

phase=is_undef(test_phase) ? 0 : test_phase;
modul=.8;
tooth_number=34;
width=1;
bore=4.8;
major_ratio=3;
rolling_ratio=1;
offset_ratio=.35;
samples=360;
scale=_cg_epitrochoid_scale(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,720);
D=_cg_epitrochoid_centre_distance(scale,major_ratio,rolling_ratio,offset_ratio);
motion=_cg_epitrochoid_motion_table(scale,major_ratio,rolling_ratio,offset_ratio,D,samples);
driver=_cg_epitrochoid_points_scaled(scale,major_ratio,rolling_ratio,offset_ratio,samples);
mate=[for(i=[0:samples-1]) _cg_epitrochoid_mate_point(scale,major_ratio,rolling_ratio,offset_ratio,D,motion,360*i/samples)];
A=D;

intersection() {
    translate([-A/2,0,0]) rotate([0,0,phase])
        _cg_gear_from_pitch_points(driver,modul,tooth_number,width,bore,20,0,false);
    translate([A/2,0,0]) rotate([0,0,_cg_mate_rotation_for_phase(motion,phase)])
        _cg_gear_from_pitch_points(mate,modul,tooth_number,width,bore,20,0,false);
}
