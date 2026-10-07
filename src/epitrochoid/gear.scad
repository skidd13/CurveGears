/***
 * Public single-gear construction for the epitrochoid family.
 * @function curve_gear_epitrochoid(modul, tooth_number, width, bore, ...)
 * @brief Build an epitrochoid non-circular gear.
 * A rolling ratio of 2:1 produces broad two-fold shaping instead of the canonical four-fold scallops. Offset 0.65 strengthens the excursions of the generating point.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid.png Epitrochoid gear 1
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_alternative.png Epitrochoid gear 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio; cusp and loop cases are rejected.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_epitrochoid_body
 * @example c
 * curve_gear_epitrochoid(1, 24, 4, 8);
 */
include <base.scad>

module _cg_epitrochoid_build(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_epitrochoid_build(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)
 * @brief Internal epitrochoid construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param major_ratio {number, default 3} Internal construction parameter.
 * @param rolling_ratio {number, default 1} Internal construction parameter.
 * @param offset_ratio {number, default .35} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(modul > 0 && (is_2d || width > 0) && bore >= 0,"epitrochoid: module, width and bore must be valid");
    assert(tooth_number >= 3 && floor(tooth_number)==tooth_number,"epitrochoid: tooth number must be an integer >= 3");
    assert(major_ratio > rolling_ratio && rolling_ratio > 0 && offset_ratio > 0 && offset_ratio < rolling_ratio,"epitrochoid: require major_ratio > rolling_ratio > 0 and 0 < offset_ratio < rolling_ratio");
    _cg_assert_samples(samples,"epitrochoid: samples must be an integer >= 120");
    unit_points=_cg_epitrochoid_points(major_ratio,rolling_ratio,offset_ratio,samples);
    scale=_cg_trochoid_scale_from_points(modul,tooth_number,unit_points);
    points=_cg_trochoid_points_scaled_from_points(scale,unit_points);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

module curve_gear_epitrochoid(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_epitrochoid_build(modul,tooth_number,width,bore,major_ratio,rolling_ratio,offset_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_epitrochoid_body(modul, tooth_number, width, bore, ...)
 * @brief Build the epitrochoid body solid without teeth.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body.png Epitrochoid body 1
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body_alternative.png Epitrochoid body 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_epitrochoid_body(1, 24, 4, 8);
 */
module curve_gear_epitrochoid_body(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_epitrochoid_build(modul,tooth_number,width,bore,major_ratio,rolling_ratio,offset_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_epitrochoid_2d
 * @brief Emit the complete epitrochoid gear profile as 2D geometry.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_2d.png Epitrochoid 2D gear 1
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_alternative_2d.png Epitrochoid 2D gear 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param major_ratio {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param rolling_ratio {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param offset_ratio {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param backlash {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param clearance {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param samples {value} Same family-specific parameter as curve_gear_epitrochoid.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_epitrochoid_2d(0.8, 34, 4.8);
 */
module curve_gear_epitrochoid_2d(modul, tooth_number, bore, major_ratio=3, rolling_ratio=1, offset_ratio=.35, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_epitrochoid_build(modul, tooth_number, 0, bore, major_ratio, rolling_ratio, offset_ratio, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_epitrochoid_body_2d
 * @brief Emit the epitrochoid body as 2D geometry with an optional signed outer-contour offset.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body_2d.png Epitrochoid 2D body 1
 * @image ../images/functions/epitrochoid/curve_gear_epitrochoid_body_alternative_2d.png Epitrochoid 2D body 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param major_ratio {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param rolling_ratio {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param offset_ratio {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param samples {value} Same family-specific parameter as curve_gear_epitrochoid_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_epitrochoid_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_epitrochoid_body_2d(modul, tooth_number, bore, major_ratio=3, rolling_ratio=1, offset_ratio=.35, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_epitrochoid_build(modul, tooth_number, 0, bore, major_ratio, rolling_ratio, offset_ratio, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
