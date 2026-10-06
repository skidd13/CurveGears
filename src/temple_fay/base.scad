/**
 * @module Temple Fay
 * @brief Crossed two-harmonic butterfly-inspired polar pitch curves.
 *
 * The project law is `r(theta)=1+0.12*sin(2 theta)+0.03*sin(4 theta)`.
 * It is a bounded two-harmonic Fourier polar curve inspired by the Butterfly
 * Curve associated with Temple H. Fay; this project name is intentional and
 * does not claim that the implementation is the historical curve itself.
 * Reference: https://mathworld.wolfram.com/ButterflyCurve.html and
 * https://en.wikipedia.org/wiki/Fourier_series.
 */
include <../common/curve_gears_math.scad>

function _cg_temple_fay_unit_radius(theta,wing=.12,fold=.03) = 1+wing*sin(2*theta)+fold*sin(4*theta);
function _cg_temple_fay_unit_points(samples=720,wing=.12,fold=.03) = [for(i=[0:samples-1]) let(theta=360*i/samples,r=_cg_temple_fay_unit_radius(theta,wing,fold)) [r*cos(theta),r*sin(theta)]];
function _cg_temple_fay_scale(modul,tooth_number,samples=720,wing=.12,fold=.03,unit_points=undef) = _cg_pitch_scale_from_points(modul,tooth_number,is_undef(unit_points) ? _cg_temple_fay_unit_points(samples,wing,fold) : unit_points,_cg_pi);
function _cg_temple_fay_points(modul,tooth_number,samples=720,wing=.12,fold=.03,unit_points=undef) = let(u=is_undef(unit_points) ? _cg_temple_fay_unit_points(samples,wing,fold) : unit_points,scale=_cg_temple_fay_scale(modul,tooth_number,samples,wing,fold,u)) _cg_scale_points(scale,u);
