/***
 * @module Fourier
 * @brief Coefficient-driven polar pitch curves.
 *
 * Each coefficient is [harmonic, amplitude, phase]. Harmonics are positive
 * integers, amplitudes are fractions of the mean pitch radius, and phases are
 * degrees. The radius is R(1 + sum(amplitude*cos(harmonic*theta+phase))).
 * This is the exact analytic model; the implementation samples it into a
 * polyline because OpenSCAD polygon/extrusion inputs are discrete. Increase
 * samples for high harmonics or large amplitudes; the positive-radius bound
 * is a validation limit, not a physical guarantee. Reference:
 * https://mathworld.wolfram.com/FourierSeries.html.
 */
include <../common/curve_gears_math.scad>
include <../common/harmonic.scad>

/**
 * @function _cg_fourier_radius
 * @brief Evaluate a Fourier polar radius at an angle.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param theta {angle} Polar angle in degrees.
 * @return {number} Polar radius.
 */
function _cg_fourier_radius(base,coefficients,theta) =
    base*_cg_harmonic_unit_radius(coefficients,theta);

/**
 * @function _cg_fourier_point
 * @brief Evaluate a Fourier pitch point in Cartesian coordinates.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param theta {angle} Polar angle in degrees.
 * @return {point} Cartesian pitch point.
 */
function _cg_fourier_point(base,coefficients,theta) = let(r=_cg_fourier_radius(base,coefficients,theta)) [r*cos(theta),r*sin(theta)];

/**
 * @function _cg_fourier_points
 * @brief Sample a complete Fourier pitch curve.
 * @param base {number > 0} Base polar radius.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @param samples {integer >= 1} Number of output samples.
 * @return {array of points} Sampled Cartesian pitch curve.
 */
function _cg_fourier_points(base,coefficients,samples) = [for(i=[0:samples-1]) _cg_fourier_point(base,coefficients,360*i/samples)];

/**
 * @function _cg_fourier_coefficients_valid
 * @brief Validate integer harmonics and bounded positive-radius amplitudes.
 * @param coefficients {array of [integer, number, angle]} Polar harmonics.
 * @return {boolean} True when the coefficient list is valid.
 */
function _cg_fourier_coefficients_valid(coefficients) =
    len(coefficients)>0
    && min([for(c=coefficients) len(c)==3 && c[0]>=1 && floor(c[0])==c[0] ? 1 : 0])==1
    && _cg_sum([for(c=coefficients) abs(c[1])])<.9;

function _cg_fourier_shape(modul,tooth_number,coefficients=[[2,.10,0]],samples=720) =
    let(base=modul*tooth_number/2,points=_cg_fourier_points(base,coefficients,samples),mx=max(_cg_sample_polar_radii(function(theta) _cg_fourier_radius(base,coefficients,theta),max(720,samples),true)))
    _cg_polar_shape_from_points(points,function(theta) _cg_fourier_radius(base,coefficients,theta),mx+.01,4*mx);

module _cg_fourier_build(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_fourier_build
 * @brief Internal fourier construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param coefficients {value, default [[2,.10,0]]} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(modul>0 && (is_2d || width>0) && bore>=0,"fourier_gear: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"fourier_gear: tooth_number must be an integer >= 3");
    assert(_cg_fourier_coefficients_valid(coefficients),"fourier_gear: coefficients must be [positive_integer_harmonic, amplitude, phase] with sum(abs(amplitude)) < 0.9");
    _cg_assert_samples(samples,"fourier_gear: samples must be an integer >= 120");
    points=_cg_fourier_shape(modul,tooth_number,coefficients,samples)[0];
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

/***
 * @function curve_gear_fourier
 * @brief Build a coefficient-driven Fourier gear.
 * A single strong third harmonic produces three clear lobes instead of the canonical mixed second/third-harmonic oval. This isolates harmonic count from mixed-phase asymmetry.
 * @image ../images/functions/fourier/curve_gear_fourier.png Fourier gear 1
 * @image ../images/functions/fourier/curve_gear_fourier_alternative.png Fourier gear 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param coefficients {array of [harmonic, amplitude, phase]} Polar harmonics relative to the mean pitch radius.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_fourier(1, 24, 4, 8, [[2, .10, 0], [3, .04, 30]]);
 */
module curve_gear_fourier(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_fourier_build(modul,tooth_number,width,bore,coefficients,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_fourier_body
 * @brief Build the Fourier body without teeth.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/fourier/curve_gear_fourier_body.png Fourier body 1
 * @image ../images/functions/fourier/curve_gear_fourier_body_alternative.png Fourier body 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param coefficients {array of [harmonic, amplitude, phase]} Polar harmonics relative to the mean pitch radius.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 */
module curve_gear_fourier_body(modul,tooth_number,width,bore,coefficients=[[2,.10,0]],pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_fourier_build(modul,tooth_number,width,bore,coefficients,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_fourier_2d
 * @brief Emit the complete fourier gear profile as 2D geometry.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/fourier/curve_gear_fourier_2d.png Fourier 2D gear 1
 * @image ../images/functions/fourier/curve_gear_fourier_alternative_2d.png Fourier 2D gear 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param coefficients {value} Same family-specific parameter as curve_gear_fourier.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_fourier.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_fourier.
 * @param backlash {value} Same family-specific parameter as curve_gear_fourier.
 * @param clearance {value} Same family-specific parameter as curve_gear_fourier.
 * @param samples {value} Same family-specific parameter as curve_gear_fourier.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_fourier_2d(0.8, 34, 4.8);
 */
module curve_gear_fourier_2d(modul, tooth_number, bore, coefficients=[[2,.10,0]], pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_fourier_build(modul, tooth_number, 0, bore, coefficients, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_fourier_body_2d
 * @brief Emit the fourier body as 2D geometry with an optional signed outer-contour offset.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/fourier/curve_gear_fourier_body_2d.png Fourier 2D body 1
 * @image ../images/functions/fourier/curve_gear_fourier_body_alternative_2d.png Fourier 2D body 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param coefficients {value} Same family-specific parameter as curve_gear_fourier_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_fourier_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_fourier_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_fourier_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_fourier_body.
 * @param samples {value} Same family-specific parameter as curve_gear_fourier_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_fourier_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_fourier_body_2d(modul, tooth_number, bore, coefficients=[[2,.10,0]], pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_fourier_build(modul, tooth_number, 0, bore, coefficients, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
