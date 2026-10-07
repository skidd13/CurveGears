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
geometry=_cg_cusp_pair_motion_geometry(modul,teeth,20,undef,undef,samples,cusps);
distance=geometry[3];
driver_outline=_cg_cusp_envelope_driver_outline(geometry[0]);
echo(str("checking intermediate phase=",phase," deg between one-degree envelope poses"));
intersection() {
    translate([-distance/2,0,0]) rotate([0,0,phase])
        linear_extrude(height=4,center=true) polygon(points=driver_outline);
    translate([distance/2,0,0])
        _cg_cusp_envelope_mate_from_geometry(geometry,modul,4,0,sweep_steps,.5,.08,phase);
}
