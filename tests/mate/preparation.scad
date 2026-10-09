/***
 * @function mate_preparation
 * @brief Prove circular and harmonic rolling invariants and shared preparation consistency.
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
    assert(max([for(i=[0:n-1]) abs(driver[i]+sqrt(mate[i][0]*mate[i][0]+mate[i][1]*mate[i][1])-D)])<1e-10,
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
cube(.01);
