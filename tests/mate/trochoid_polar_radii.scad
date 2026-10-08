/***
 * @function mate_trochoid_polar_radii
 * @brief Compare indexed motion radii with independent full-outline ray scans for both trochoid families.
 * Source: [`mate/trochoid_polar_radii.scad`](mate/trochoid_polar_radii.scad)
 */
include <../../src/hypotrochoid/mate.scad>
include <../../src/epitrochoid/mate.scad>
function ray_radius(points,angle) = max([for(i=[0:len(points)-1])
    let(a=points[i],b=points[(i+1)%len(points)],v=[cos(angle),sin(angle)],
        edge=b-a,den=v[0]*edge[1]-v[1]*edge[0],
        u=den==0 ? -1 : (a[0]*v[1]-a[1]*v[0])/den,
        r=den==0 ? -1 : (a[0]*edge[1]-a[1]*edge[0])/den)
    if(u>=-1e-9 && u<=1+1e-9 && r>=0) r]);
for(family=[0,1],ratios=[[3,1,.35],[5,1,.35],[2,1,.65]]) {
    R=ratios[0];r=ratios[1];d=ratios[2];n=240;
    points=family==0 ? _cg_hypotrochoid_points_scaled(1,R,r,d,n) : _cg_epitrochoid_points_scaled(1,R,r,d,n);
    table=_cg_trochoid_polar_table(points);
    direct=family==0 ? _cg_hypotrochoid_driver_radii(1,R,r,d,n) : _cg_epitrochoid_driver_radii(1,R,r,d,n);
    mid=family==0 ? _cg_hypotrochoid_motion_radii(1,R,r,d,n) : _cg_epitrochoid_motion_radii(1,R,r,d,n);
    for(i=[0:13:n-1]) {
        angle=360*i/n;
        assert(abs(direct[i]-ray_radius(points,angle))<1e-8,"driver radius uses curve parameter instead of polar angle");
        assert(abs(mid[i]-ray_radius(points,angle+180/n))<1e-8,"midpoint radius differs from the actual driver polygon");
        assert(abs(_cg_trochoid_radius_at_polar_angle(table,angle+360)-direct[i])<1e-8);
        assert(abs(_cg_trochoid_radius_at_polar_angle(table,angle-360)-direct[i])<1e-8);
    }
    D=_cg_solve_mate_distance(mid,max(direct)+.01,4*max(direct));
    integration=_cg_motion_integration_state(direct,mid,D);
    mate=_cg_mate_points_from_radius_samples_with_state(direct,D,integration);
    assert(abs(_cg_motion_closure_error(integration[2]))<.08,"correct physical-radius motion does not close");
    for(i=[0:13:n-1])
        assert(abs(_cg_vlen(mate[i])+ray_radius(points,360*i/n)-D)<1e-8,"mate pitch radius does not complement the actual driver");
}
echo("PASS: exact physical-ray radii, phase wrapping and conjugate pitch distances for both trochoid families");
cube(.01);
