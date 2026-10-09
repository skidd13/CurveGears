/**
 * @module Temple Fay
 * @brief Crossed two-harmonic butterfly-inspired polar pitch curves.
 *
 * The project law is `r(theta)=1+0.18*sin(2 theta)+0.05*sin(4 theta)`.
 * It is a bounded two-harmonic Fourier polar curve inspired by the Butterfly
 * Curve associated with Temple H. Fay; this project name is intentional and
 * does not claim that the implementation is the historical curve itself.
 * Reference: https://mathworld.wolfram.com/ButterflyCurve.html and
 * https://en.wikipedia.org/wiki/Fourier_series.
 */
include <../common/curve_gears_math.scad>
include <../common/harmonic.scad>

function _cg_temple_fay_unit_radius(theta,wing=.18,fold=.05) = _cg_harmonic_unit_radius([[2,wing,-90],[4,fold,-90]],theta);
function _cg_temple_fay_shape(modul,tooth_number,wing=.18,fold=.05,samples=720) =
    _cg_polar_shape(
        function(theta) _cg_temple_fay_unit_radius(theta,wing,fold),
        modul,tooth_number,samples,
        function(scale) [scale*(1+wing+fold)+.01,3*scale],
        true);
