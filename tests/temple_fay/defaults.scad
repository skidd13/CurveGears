/***
 * @function temple_fay_defaults
 * @brief Bind default reference spacing to the pitch curve emitted by the default gear.
 * Source: [`temple_fay/defaults.scad`](temple_fay/defaults.scad)
 */
include <../../src/temple_fay/pair.scad>
for(m=[.8,1.2],z=[24,34]) {
    points=_cg_temple_fay_points(m,z);
    scale=_cg_vlen(points[0]); // At zero degrees both sine harmonics vanish.
    assert(abs(curve_gear_temple_fay_centre_distance(m,z)-2*scale)<1e-9,
        "default helper spacing does not describe the default pitch curve");
    assert(abs(curve_gear_temple_fay_centre_distance(m,z)-curve_gear_temple_fay_centre_distance(m,z,.18,.05))<1e-9);
}
echo("PASS: default Temple Fay reference spacing matches the gear");
cube(.01);
