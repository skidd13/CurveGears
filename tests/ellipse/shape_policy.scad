/***
 * @function ellipse_shape_policy
 * @brief Preserve analytical axes, physical radii and solver bounds across sampling densities.
 * Source: [`ellipse/shape_policy.scad`](ellipse/shape_policy.scad)
 */
include <../../src/ellipse/mate.scad>
function _test_ellipse_centre_distance(a,b,n) =
    _cg_solve_mate_distance([for(i=[0:n-1]) _cg_ellipse_radius(a,b,360*(i+.5)/n)],a+.01,3*a);
for(e=[0,.62,.94],n=[120,240,480,960]) {
    axes=_cg_ellipse_axes(.8,34,e);
    shape=_cg_ellipse_shape(.8,34,e,n);
    expected=[for(i=[0:n-1]) _cg_ellipse_driver_point(axes[0],axes[1],360*i/n)];
    assert(shape[0]==expected,"ellipse analytical-axis polygon was rescaled");
    assert(shape[2]==axes[0]+.01 && shape[3]==3*axes[0],"ellipse analytical bounds changed");
    assert(abs(curve_gear_ellipse_centre_distance(.8,34,e,n)-_test_ellipse_centre_distance(axes[0],axes[1],n))<1e-9);
    for(theta=[0,13,89,177,359])
        assert(shape[1](theta)==_cg_ellipse_radius(axes[0],axes[1],theta),"ellipse physical radius changed");
}
cube(.01);
