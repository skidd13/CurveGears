/***
 * @function temple_fay_phase_equivalence
 * @brief Compare the public dynamic helpers with the shared preparation contract.
 * Source: [`temple_fay/phase_equivalence.scad`](temple_fay/phase_equivalence.scad)
 */
include <../../src/temple_fay/pair.scad>
$fn=24;
shape=_cg_temple_fay_shape(.8,34,.18,.05,120);
data=_cg_mate_preparation(_cg_sample_polar_radii(shape[1],120),_cg_sample_polar_radii(shape[1],120,true),shape[2],shape[3]);
for(phase=[15,43]) {
    assert(abs(curve_gear_temple_fay_centre_distance(.8,34,.18,.05,120)-data[0])<1e-9);
    assert(abs(curve_gear_temple_fay_mate_rotation(.8,34,.18,.05,120,phase)-_cg_polar_mate_rotation(shape,120,phase))<1e-9);
    assert(abs(curve_gear_temple_fay_mate_rotation(.8,34,.18,.05,120,phase)-(180-phase))>1e-4,
        "Temple Fay must use the dynamic conjugate rotation");
    for(assembled=[false,true])
        translate([assembled ? 0 : 120,0,0])
            curve_gear_temple_fay_pair(.8,34,1,4.8,samples=120,phase=phase,together_built=assembled);
}
cube(.01);
