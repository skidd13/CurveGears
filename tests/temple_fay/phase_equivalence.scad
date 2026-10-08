/***
 * @function temple_fay_phase_equivalence
 * @brief Compare assembled and separated pair geometry with independent single-rotation references.
 * Source: [`temple_fay/phase_equivalence.scad`](temple_fay/phase_equivalence.scad)
 */
// @regression: sentinel-cube 0.01
include <../../src/temple_fay/pair.scad>
$fn=24;
module reference(phase,assembled) {
    points=_cg_temple_fay_points(.8,34,120,.18,.05);
    distance=curve_gear_temple_fay_centre_distance(.8,34,.18,.05,120);
    display=2*max([for(p=points) _cg_vlen(p)])+4*.8;
    translate([assembled ? -distance/2 : 0,0,0]) rotate([0,0,phase])
        curve_gear_temple_fay(.8,34,1,4.8,samples=120);
    translate([assembled ? distance/2 : display,0,0]) rotate([0,0,180-phase])
        curve_gear_temple_fay(.8,34,1,4.8,samples=120);
}
for(assembled=[false,true],phase=[15,43]) translate([100,0,0]) {
    difference() {
        curve_gear_temple_fay_pair(.8,34,1,4.8,samples=120,phase=phase,together_built=assembled);
        reference(phase,assembled);
    }
    difference() {
        reference(phase,assembled);
        curve_gear_temple_fay_pair(.8,34,1,4.8,samples=120,phase=phase,together_built=assembled);
    }
}
cube(.01);
