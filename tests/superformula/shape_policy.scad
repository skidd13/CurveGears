/***
 * @function superformula_shape_policy
 * @brief Preserve perimeter scaling and the fixed 720-sample solver-bound policy.
 * Source: [`superformula/shape_policy.scad`](superformula/shape_policy.scad)
 */
include <../../src/superformula/mate.scad>

function _test_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n) =
    [for(i=[0:n-1]) _cg_superformula_radius(scale,symmetry,a,b,n1,n2,n3,360*(i+.5)/n)];
function _test_superformula_centre_distance(scale,symmetry,a,b,n1,n2,n3,n) =
    let(mx=_cg_superformula_max_radius(scale,symmetry,a,b,n1,n2,n3,720),mid=_test_superformula_motion_radii(scale,symmetry,a,b,n1,n2,n3,n))
    _cg_solve_mate_distance(mid,mx+.01,4*mx);

for(n=[120,360,960],m=[4,6]) {
    scale=_cg_superformula_scale(.8,34,m,1,1,2.4,3.4,3.4,n);
    shape=_cg_superformula_shape(.8,34,m,1,1,2.4,3.4,3.4,n);
    mx=_cg_superformula_max_radius(scale,m,1,1,2.4,3.4,3.4,720);
    expected=_cg_superformula_points(scale,m,1,1,2.4,3.4,3.4,n);
    assert(max([for(i=[0:n-1]) _cg_vlen(_cg_vsub(shape[0][i],expected[i]))])<1e-10,"superformula polygon changed");
    assert(abs(shape[2]-(mx+.01))<1e-10 && abs(shape[3]-4*mx)<1e-10,"superformula bounds changed");
    assert(abs(curve_gear_superformula_centre_distance(.8,34,m,1,1,2.4,3.4,3.4,n)-_test_superformula_centre_distance(scale,m,1,1,2.4,3.4,3.4,n))<1e-9);
}
cube(.01);
