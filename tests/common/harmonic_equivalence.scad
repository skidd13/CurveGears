/***
 * @function common_harmonic_equivalence
 * @brief Check named harmonic adapters against their independent analytic laws and retain distinct scaling policies.
 * Source: [`common/harmonic_equivalence.scad`](common/harmonic_equivalence.scad)
 */
include <../../src/fourier/base.scad>
include <../../src/lobed/base.scad>
include <../../src/pascal/base.scad>
include <../../src/temple_fay/base.scad>
include <../../src/cosine_quintic/base.scad>
for(theta=[0:.5:360]) {
    assert(abs(_cg_lobed_unit_radius(4,.13,theta)-(1+.13*cos(4*theta)))<1e-12);
    // Pascal deliberately supports eccentricity beyond Fourier's public .9 limit.
    assert(abs(_cg_pascal_unit_radius(.95,theta)-(1+.95*cos(theta)))<1e-12);
    assert(abs(_cg_temple_fay_unit_radius(theta,.32,.12)-(1+.32*sin(2*theta)+.12*sin(4*theta)))<1e-12);
    assert(abs(_cg_cosine_quintic_unit_radius(theta,.19,2)-(1+.19*pow(cos(2*theta),5)))<1e-12);
    assert(abs(_cg_fourier_radius(3,[[2,.1,0],[3,.2,45]],theta)-3*(1+.1*cos(2*theta)+.2*cos(3*theta+45)))<1e-12);
}
assert(!_cg_fourier_coefficients_valid([[1,.95,0]]),"Fourier public amplitude domain changed");
shape=_cg_lobed_shape(.8,34,4,.13,720);
assert(abs(_cg_closed_polyline_perimeter(shape[0])-_cg_pi*.8*34)<1e-9,"lobed perimeter scale changed");
assert(_cg_fourier_radius(.8*34/2,[[2,.1,0]],0)==.8*34/2*1.1,"Fourier radius scale changed");
cube(.01);
