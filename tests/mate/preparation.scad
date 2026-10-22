/***
 * @function mate_preparation
 * @brief Prove rolling closure, complementary radii, tangent conjugacy and shared preparation consistency.
 * Source: [`mate/preparation.scad`](mate/preparation.scad)
 */
include <../../src/common/mate/preparation.scad>

n=240;
for(amplitude=[0,2]) {
    driver=[for(i=[0:n-1]) 10+amplitude*cos(360*i/n)];
    mid=[for(i=[0:n-1]) 10+amplitude*cos(360*(i+.5)/n)];
    prepared=_cg_mate_preparation(driver,mid,12.01,40);
    D=prepared[0];
    motion=prepared[1];
    mate=prepared[2];
    assert(abs(_cg_motion_closure_error(motion))<1e-6,"prepared rolling closure failed");
    assert(max([for(i=[0:n-1]) abs(driver[i]+sqrt(mate[(n-i)%n][0]*mate[(n-i)%n][0]+mate[(n-i)%n][1]*mate[(n-i)%n][1])-D)])<1e-10,
        "prepared complementary radius failed");
    for(i=[0:n-1])
        assert(abs(motion[i+1][1]-motion[i][1]-(360/n)*mid[i]/(D-mid[i]))<1e-10,"rolling increment changed");
    if(amplitude==0) {
        assert(abs(D-20)<1e-8,"circular analytic centre distance changed");
        for(phase=[-360,-15,0,15,43,90,180,270,359,360,735])
            assert(abs(_cg_mate_rotation_for_phase(motion,phase)-(180-phase))<1e-6,"circular multi-turn motion changed");
    }
    assert(_cg_mate_preparation(driver,mid,distance=D)[2]==mate,"pre-solved distance changed points");
}
function _cg_test_rotate_vector(vector,angle) =
    [vector[0]*cos(angle)-vector[1]*sin(angle),vector[0]*sin(angle)+vector[1]*cos(angle)];
function _cg_test_tangent_line_error(a,b) =
    atan2(abs(a[0]*b[1]-a[1]*b[0]),abs(a[0]*b[0]+a[1]*b[1]));

// An asymmetric radial law exercises the sign that a circle cannot expose.
asymmetric_n=240;
asymmetric_radii=[for(i=[0:asymmetric_n-1]) 10+2*sin(360*i/asymmetric_n)+.8*cos(720*i/asymmetric_n+20)];
asymmetric_mid=[for(i=[0:asymmetric_n-1]) 10+2*sin(360*(i+.5)/asymmetric_n)+.8*cos(720*(i+.5)/asymmetric_n+20)];
asymmetric_points=_cg_polar_points_from_radii(asymmetric_radii);
asymmetric_prepared=_cg_mate_preparation(asymmetric_radii,asymmetric_mid,max(asymmetric_mid)+.01,4*max(asymmetric_mid));
asymmetric_mate=asymmetric_prepared[2];
asymmetric_correspondence=[for(i=[0:asymmetric_n-1]) asymmetric_mate[(asymmetric_n-i)%asymmetric_n]];
asymmetric_motion=asymmetric_prepared[1];
asymmetric_tangent_errors=[for(i=[0:asymmetric_n-1])
    let(previous=(i-1+asymmetric_n)%asymmetric_n,next=(i+1)%asymmetric_n,theta=360*i/asymmetric_n,phi=asymmetric_motion[i][1],
        driver_tangent=_cg_test_rotate_vector(_cg_vsub(asymmetric_points[next],asymmetric_points[previous]),-theta),
        mate_tangent=_cg_test_rotate_vector(_cg_vsub(asymmetric_correspondence[next],asymmetric_correspondence[previous]),180+phi))
    _cg_test_tangent_line_error(driver_tangent,mate_tangent)];
assert(max(asymmetric_tangent_errors)<.1,"asymmetric mate pitch curves must remain tangent at every sampled contact");
for(i=[0:asymmetric_n-1])
    assert(abs(_cg_vlen(asymmetric_correspondence[i])+asymmetric_radii[i]-asymmetric_prepared[0])<1e-9,
        "asymmetric mate pitch radii must complement the driver at every sample");

cube(.01);
