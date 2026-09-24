/***
 * @function mate_motion_phase_cases
 * @brief Shared mate-motion phase regression.
 * Source: [`mate/motion/phase_cases.scad`](mate/motion/phase_cases.scad)
 *
 * This is intentionally a small analytic fixture. It checks that every
 * dynamic family accepts negative, zero, positive and full-turn phases while
 * retaining the continuous wraparound convention used by pair assembly.
 */
include <../../../src/ellipse/mate.scad>
include <../../../src/lobed/mate.scad>
include <../../../src/superformula/mate.scad>
include <../../../src/pascal/mate.scad>
include <../../../src/epitrochoid/mate.scad>
include <../../../src/fourier/mate.scad>

function _cg_phase_cases_ok(z,n,p,t) =
    abs(n-(z+360)) < 1e-6 && abs(t-(z-360)) < 1e-6 && p != undef;

ellipse_zero=curve_gear_ellipse_mate_rotation(.8,34,.72,360,0);
ellipse_negative=curve_gear_ellipse_mate_rotation(.8,34,.72,360,-360);
ellipse_positive=curve_gear_ellipse_mate_rotation(.8,34,.72,360,90);
ellipse_turn=curve_gear_ellipse_mate_rotation(.8,34,.72,360,360);
assert(_cg_phase_cases_ok(ellipse_zero,ellipse_negative,ellipse_positive,ellipse_turn),"ellipse mate phase wraparound failed");

lobed_zero=curve_gear_lobed_mate_rotation(.8,34,4,.13,360,0);
lobed_negative=curve_gear_lobed_mate_rotation(.8,34,4,.13,360,-360);
lobed_positive=curve_gear_lobed_mate_rotation(.8,34,4,.13,360,90);
lobed_turn=curve_gear_lobed_mate_rotation(.8,34,4,.13,360,360);
assert(_cg_phase_cases_ok(lobed_zero,lobed_negative,lobed_positive,lobed_turn),"lobed mate phase wraparound failed");

superformula_zero=curve_gear_superformula_mate_rotation(.8,34,4,1,1,2.4,2.4,2.4,240,0);
superformula_negative=curve_gear_superformula_mate_rotation(.8,34,4,1,1,2.4,2.4,2.4,240,-360);
superformula_positive=curve_gear_superformula_mate_rotation(.8,34,4,1,1,2.4,2.4,2.4,240,90);
superformula_turn=curve_gear_superformula_mate_rotation(.8,34,4,1,1,2.4,2.4,2.4,240,360);
assert(_cg_phase_cases_ok(superformula_zero,superformula_negative,superformula_positive,superformula_turn),"superformula mate phase wraparound failed");

pascal_zero=curve_gear_pascal_mate_rotation(.8,34,.68,240,0);
pascal_negative=curve_gear_pascal_mate_rotation(.8,34,.68,240,-360);
pascal_positive=curve_gear_pascal_mate_rotation(.8,34,.68,240,90);
pascal_turn=curve_gear_pascal_mate_rotation(.8,34,.68,240,360);
assert(_cg_phase_cases_ok(pascal_zero,pascal_negative,pascal_positive,pascal_turn),"pascal mate phase wraparound failed");

epitrochoid_zero=curve_gear_epitrochoid_mate_rotation(.8,34,3,1,.35,240,0);
epitrochoid_negative=curve_gear_epitrochoid_mate_rotation(.8,34,3,1,.35,240,-360);
epitrochoid_positive=curve_gear_epitrochoid_mate_rotation(.8,34,3,1,.35,240,90);
epitrochoid_turn=curve_gear_epitrochoid_mate_rotation(.8,34,3,1,.35,240,360);
assert(_cg_phase_cases_ok(epitrochoid_zero,epitrochoid_negative,epitrochoid_positive,epitrochoid_turn),"epitrochoid mate phase wraparound failed");

fourier_coefficients=[[2,.10,0],[3,.04,30]];
fourier_zero=curve_gear_fourier_mate_rotation(.8,34,fourier_coefficients,240,0);
fourier_negative=curve_gear_fourier_mate_rotation(.8,34,fourier_coefficients,240,-360);
fourier_positive=curve_gear_fourier_mate_rotation(.8,34,fourier_coefficients,240,90);
fourier_turn=curve_gear_fourier_mate_rotation(.8,34,fourier_coefficients,240,360);
assert(_cg_phase_cases_ok(fourier_zero,fourier_negative,fourier_positive,fourier_turn),"fourier mate phase wraparound failed");

cube([.01,.01,4]);
