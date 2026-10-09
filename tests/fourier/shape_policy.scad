/***
 * @function fourier_shape_policy
 * @brief Preserve midpoint maximum-radius sampling and the existing distance bracket.
 * Source: [`fourier/shape_policy.scad`](fourier/shape_policy.scad)
 */
include <../../src/fourier/mate.scad>
for(n=[120,360,960],coefficients=[[[2,.10,0]],[[2,.12,23],[5,.03,-17]]]) {
    base=.8*34/2;
    shape=_cg_fourier_shape(.8,34,coefficients,n);
    mx=_cg_fourier_max_radius(base,coefficients,max(720,n));
    assert(shape[0]==_cg_fourier_points(base,coefficients,n),"Fourier polygon changed");
    assert(shape[2]==mx+.01 && shape[3]==4*mx,"Fourier midpoint bounds changed");
    assert(abs(curve_gear_fourier_centre_distance(.8,34,coefficients,n)-_cg_fourier_centre_distance(base,coefficients,n))<1e-9);
}
cube(.01);
