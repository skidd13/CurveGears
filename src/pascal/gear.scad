/***
 * Public single-gear construction for the pascal family.
 * @function curve_gear_pascal
 * @brief Build a Pascal-curve non-circular gear.
 * Eccentricity 0.28 gives a convex egg-like outline instead of the canonical non-convex 0.60 limacon. Twenty coarse teeth emphasise the body contour. This contrasts the regular conjugate domain with the experimental dimpled case.
 * @image ../images/functions/pascal/curve_gear_pascal.png Pascal gear 1
 * @image ../images/functions/pascal/curve_gear_pascal_alternative.png Pascal gear 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.25} Pascal curve eccentricity; e >= 0.5 is non-convex.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_pascal_body
 * @example c
 * curve_gear_pascal(1, 24, 4, 8);
 */
include <base.scad>

module _cg_pascal_build(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_pascal_build
 * @brief Internal pascal construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param eccentricity {number, default 0.25} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(eccentricity >= 0 && eccentricity < 1,"pascal_gear: eccentricity must satisfy 0 <= eccentricity < 1");

    shape=_cg_pascal_shape(modul,tooth_number,eccentricity,samples);
    points=shape[0];
    scale=_cg_vlen(points[0])/(1+eccentricity);
    min_r=_cg_pascal_min_radius(scale,eccentricity);
    if(bore > 0)
        assert(min_r > bore/2,"pascal_gear: bore exceeds the minimum pitch radius; reduce bore or eccentricity");
    if(eccentricity >= 0.5)
        echo("pascal_gear: non-convex Pascal geometry is experimental; full-cycle physical meshing remains unproven");

    _cg_assert_samples(samples);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, _cg_pascal_requires_radial_root(eccentricity), backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, _cg_pascal_requires_radial_root(eccentricity), backlash, clearance, body_only);
    }
}

module curve_gear_pascal(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_pascal_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_pascal_body
 * @brief Build the Pascal body solid without teeth.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/pascal/curve_gear_pascal_body.png Pascal body 1
 * @image ../images/functions/pascal/curve_gear_pascal_body_alternative.png Pascal body 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.25} Pascal curve eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_pascal_body(1, 24, 4, 8);
 */
module curve_gear_pascal_body(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_pascal_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_pascal_2d
 * @brief Emit the complete pascal gear profile as 2D geometry.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/pascal/curve_gear_pascal_2d.png Pascal 2D gear 1
 * @image ../images/functions/pascal/curve_gear_pascal_alternative_2d.png Pascal 2D gear 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param eccentricity {value} Same family-specific parameter as curve_gear_pascal.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_pascal.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_pascal.
 * @param backlash {value} Same family-specific parameter as curve_gear_pascal.
 * @param clearance {value} Same family-specific parameter as curve_gear_pascal.
 * @param samples {value} Same family-specific parameter as curve_gear_pascal.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_pascal_2d(0.8, 34, 4.8);
 */
module curve_gear_pascal_2d(modul, tooth_number, bore, eccentricity=0.25, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_pascal_build(modul, tooth_number, 0, bore, eccentricity, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_pascal_body_2d
 * @brief Emit the pascal body as 2D geometry with an optional signed outer-contour offset.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/pascal/curve_gear_pascal_body_2d.png Pascal 2D body 1
 * @image ../images/functions/pascal/curve_gear_pascal_body_alternative_2d.png Pascal 2D body 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param eccentricity {value} Same family-specific parameter as curve_gear_pascal_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_pascal_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_pascal_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_pascal_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_pascal_body.
 * @param samples {value} Same family-specific parameter as curve_gear_pascal_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_pascal_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_pascal_body_2d(modul, tooth_number, bore, eccentricity=0.25, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_pascal_build(modul, tooth_number, 0, bore, eccentricity, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
