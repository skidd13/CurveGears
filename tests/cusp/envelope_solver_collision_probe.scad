// @regression: manual
/**
 * @function cusp_envelope_collision_probe
 * @brief Check that sampled intermediate driver poses clear the swept-envelope mate.
 * Source: [`cusp/envelope_solver_collision_probe.scad`](cusp/envelope_solver_collision_probe.scad)
 */
include <../../src/cusp/pair.scad>

cusps=3;
modul=1.2;
teeth=cusps==3 ? 36 : 12*cusps;
samples=720;
sweep_steps=360;
phase=.25;
// Empty mate_file retains the independent native-envelope reference path.
mate_file="";
distance_offset=0;
geometry=mate_file=="" || is_undef(cached_driver_outline) ?
    _cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples,cusps) : undef;
distance=(is_undef(cached_distance) ? geometry[3] : cached_distance)+distance_offset;
driver_outline=is_undef(cached_driver_outline) ? _cg_cusp_envelope_driver_outline(geometry[0]) : cached_driver_outline;
motion=is_undef(cached_motion) ? geometry[4][2] : cached_motion;
echo(str("checking intermediate phase=",phase," deg between one-degree envelope poses"));
if (mate_file=="") {
    intersection() {
        translate([-distance/2,0,0]) rotate([0,0,phase])
            linear_extrude(height=4,center=true) polygon(points=driver_outline);
        translate([distance/2,0,0])
            _cg_cusp_envelope_mate_from_geometry(geometry,modul,4,0,sweep_steps,.5,.08,phase);
    }
} else {
    // Both solids are equal centred extrusions, so intersect their planar
    // outlines before extruding instead of converting a detailed STL to CSG.
    linear_extrude(height=4,center=true)
        intersection() {
            translate([-distance/2,0]) rotate(phase) polygon(points=driver_outline);
            translate([distance/2,0])
                rotate(_cg_mate_rotation_for_phase(motion,phase)
                       -_cg_mate_rotation_for_phase(motion,0))
                    import(mate_file);
        }
}
