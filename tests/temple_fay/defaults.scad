/***
 * @function temple_fay_defaults
 * @brief Bind default reference spacing to the pitch curve emitted by the default gear.
 * Source: [`temple_fay/defaults.scad`](temple_fay/defaults.scad)
 */
include <../../src/temple_fay/pair.scad>
for(m=[.8,1.2],z=[24,34]) {
    shape=_cg_temple_fay_shape(m,z);
    distance=_cg_polar_mate_distance(shape,720);
    assert(abs(curve_gear_temple_fay_centre_distance(m,z)-distance)<1e-9,
        "default helper spacing does not describe the dynamic mate solver");
    assert(abs(curve_gear_temple_fay_centre_distance(m,z)-curve_gear_temple_fay_centre_distance(m,z,.18,.05))<1e-9);
}
echo("PASS: default Temple Fay reference spacing matches the gear");
cube(.01);
