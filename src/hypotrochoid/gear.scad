/***
 * @function curve_gear_hypotrochoid(modul, tooth_number, width, bore, ...)
 * @brief Build a hypotrochoid non-circular gear.
 * A 5:1 rolling ratio and offset 0.35 produce five-fold shaping rather than the canonical three-fold outline. The alternative changes the curve itself, not merely the pair spacing.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid.png Hypotrochoid gear 1
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_alternative.png Hypotrochoid gear 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation.
 * @example c
 * curve_gear_hypotrochoid(1, 24, 4, 8);
 */
include <base.scad>

/***
 * @function _cg_hypotrochoid_build(modul, tooth_number, width, bore, major_ratio=3, rolling_ratio=1, offset_ratio=0.35, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_only=false)
 * @brief Construct a validated hypotrochoid body, gear, or mate boundary.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in millimetres.
 * @param bore {number >= 0} Centre bore diameter in millimetres.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-circle radius ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle radius ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 120, default 720} Pitch-curve sample count.
 * @param orientation {angle, default 0} Display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 */
module _cg_hypotrochoid_build(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
    assert(modul>0 && (is_2d || width>0) && bore>=0,"hypotrochoid: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"hypotrochoid: tooth number must be an integer >= 3");
    assert(major_ratio>rolling_ratio && rolling_ratio>0 && offset_ratio>0 && offset_ratio<rolling_ratio,"hypotrochoid: require major_ratio > rolling_ratio > 0 and 0 < offset_ratio < rolling_ratio");
    _cg_assert_samples(samples,"hypotrochoid: samples must be an integer >= 120");
    points=_cg_hypotrochoid_shape(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples)[0];
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

module curve_gear_hypotrochoid(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_hypotrochoid_build(modul,tooth_number,width,bore,major_ratio,rolling_ratio,offset_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/** @function curve_gear_hypotrochoid_body
 * @brief Build the hypotrochoid body solid without teeth.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png Hypotrochoid body 1
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative.png Hypotrochoid body 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation.
 */
module curve_gear_hypotrochoid_body(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_hypotrochoid_build(modul,tooth_number,width,bore,major_ratio,rolling_ratio,offset_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_hypotrochoid_2d
 * @brief Emit the complete hypotrochoid gear profile as 2D geometry.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_2d.png Hypotrochoid 2D gear 1
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_alternative_2d.png Hypotrochoid 2D gear 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param major_ratio {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param rolling_ratio {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param offset_ratio {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param backlash {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param clearance {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param samples {value} Same family-specific parameter as curve_gear_hypotrochoid.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_hypotrochoid_2d(0.8, 34, 4.8);
 */
module curve_gear_hypotrochoid_2d(modul, tooth_number, bore, major_ratio=3, rolling_ratio=1, offset_ratio=.35, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_hypotrochoid_build(modul, tooth_number, 0, bore, major_ratio, rolling_ratio, offset_ratio, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_hypotrochoid_body_2d
 * @brief Emit the hypotrochoid body as 2D geometry with an optional signed outer-contour offset.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_2d.png Hypotrochoid 2D body 1
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body_alternative_2d.png Hypotrochoid 2D body 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param major_ratio {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param rolling_ratio {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param offset_ratio {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param samples {value} Same family-specific parameter as curve_gear_hypotrochoid_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_hypotrochoid_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_hypotrochoid_body_2d(modul, tooth_number, bore, major_ratio=3, rolling_ratio=1, offset_ratio=.35, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_hypotrochoid_build(modul, tooth_number, 0, bore, major_ratio, rolling_ratio, offset_ratio, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
