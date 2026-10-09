/***
 * @function fourier_shape_policy
 * @brief Preserve midpoint maximum-radius sampling and the existing distance bracket.
 * Source: [`fourier/shape_policy.scad`](fourier/shape_policy.scad)
 */
include <../../src/fourier/mate.scad>
function _test_fourier_motion_radii(base,coefficients,n) = [for(i=[0:n-1]) _cg_fourier_radius(base,coefficients,360*(i+.5)/n)];
function _test_fourier_centre_distance(base,coefficients,n) =
    let(mx=max(_test_fourier_motion_radii(base,coefficients,max(720,n))))
    _cg_solve_mate_distance(_test_fourier_motion_radii(base,coefficients,n),mx+.01,4*mx);
for(n=[120,360,960],coefficients=[[[2,.10,0]],[[2,.12,23],[5,.03,-17]]]) {
    base=.8*34/2;
    shape=_cg_fourier_shape(.8,34,coefficients,n);
    mx=max(_test_fourier_motion_radii(base,coefficients,max(720,n)));
    assert(shape[0]==_cg_fourier_points(base,coefficients,n),"Fourier polygon changed");
    assert(shape[2]==mx+.01 && shape[3]==4*mx,"Fourier midpoint bounds changed");
    assert(abs(curve_gear_fourier_centre_distance(.8,34,coefficients,n)-_test_fourier_centre_distance(base,coefficients,n))<1e-9);
}
cube(.01);
