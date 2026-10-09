/***
 * @function common_saturating_equivalence
 * @brief Check Logistic and Tanh adapters across small, canonical and extreme finite gains.
 * Source: [`common/saturating_equivalence.scad`](common/saturating_equivalence.scad)
 */
include <../../src/logistic_dwell/base.scad>
include <../../src/tanh_triad/base.scad>
for(theta=[0:.5:360],gain=[1e-12,3,8,1000,1e300],depth=[.01,.2,.46]) {
    radius=_cg_logistic_dwell_unit_radius(theta,gain,depth);
    reference=1+depth/(1+exp(-gain*sin(2*theta)))-depth/2;
    assert(abs(radius-reference)<1e-12,"logistic law changed");
    assert(radius>0 && radius>=1-depth/2-1e-12 && radius<=1+depth/2+1e-12,"logistic bounds changed");
}
for(theta=[0:.5:360],transition=[1e-12,.8,1.8,1000,1e300]) {
    radius=_cg_tanh_triad_unit_radius(theta,transition,.13,.03);
    reference=1+.13*_cg_tanh(transition*sin(3*theta))+.03*cos(6*theta+20);
    assert(abs(radius-reference)<1e-12,"tanh correction ownership changed");
}
cube(.01);
