/***
 * Public single-gear construction for the ellipse family.
 * @function curve_gear_ellipse(modul, tooth_number, width, bore, ...)
 * @brief Build an elliptical non-circular gear.
 * Eccentricity 0.94 produces a long narrow ellipse rather than the canonical 0.72 oval. The sharper ends and narrow transverse span reveal where tooth placement becomes demanding.
 * @image ../images/functions/ellipse/curve_gear_ellipse.png Ellipse gear 1
 * @image ../images/functions/ellipse/curve_gear_ellipse_alternative.png Ellipse gear 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity; zero is circular.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_ellipse_body
 * @example c
 * curve_gear_ellipse(1, 24, 4, 8);
 */
include <base.scad>

module _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0,body_only=false)
 * @brief Internal ellipse construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param eccentricity {number, default 0.62} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 480} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(eccentricity >= 0 && eccentricity < 1,"elliptical_gear: eccentricity must satisfy 0 <= e < 1");
    points=_cg_ellipse_shape(modul,tooth_number,eccentricity,samples)[0];

    _cg_assert_samples(samples);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

module curve_gear_ellipse(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0) {
    _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_ellipse_body(modul, tooth_number, width, bore, ...)
 * @brief Build the elliptical body solid without teeth.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/ellipse/curve_gear_ellipse_body.png Ellipse body 1
 * @image ../images/functions/ellipse/curve_gear_ellipse_body_alternative.png Ellipse body 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_ellipse_body(1, 24, 4, 8);
 */
module curve_gear_ellipse_body(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0) {
    _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_ellipse_2d
 * @brief Emit the complete ellipse gear profile as 2D geometry.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/ellipse/curve_gear_ellipse_2d.png Ellipse 2D gear 1
 * @image ../images/functions/ellipse/curve_gear_ellipse_alternative_2d.png Ellipse 2D gear 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param eccentricity {value} Same family-specific parameter as curve_gear_ellipse.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_ellipse.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_ellipse.
 * @param backlash {value} Same family-specific parameter as curve_gear_ellipse.
 * @param clearance {value} Same family-specific parameter as curve_gear_ellipse.
 * @param samples {value} Same family-specific parameter as curve_gear_ellipse.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_ellipse_2d(0.8, 34, 4.8);
 */
module curve_gear_ellipse_2d(modul, tooth_number, bore, eccentricity=0.62, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=480, orientation=0) {
    _cg_ellipse_build(modul, tooth_number, 0, bore, eccentricity, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_ellipse_body_2d
 * @brief Emit the ellipse body as 2D geometry with an optional signed outer-contour offset.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/ellipse/curve_gear_ellipse_body_2d.png Ellipse 2D body 1
 * @image ../images/functions/ellipse/curve_gear_ellipse_body_alternative_2d.png Ellipse 2D body 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param eccentricity {value} Same family-specific parameter as curve_gear_ellipse_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_ellipse_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_ellipse_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_ellipse_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_ellipse_body.
 * @param samples {value} Same family-specific parameter as curve_gear_ellipse_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_ellipse_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_ellipse_body_2d(modul, tooth_number, bore, eccentricity=0.62, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=480, orientation=0, body_offset=0) {
    _cg_ellipse_build(modul, tooth_number, 0, bore, eccentricity, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
