/***
 * Public single-gear construction for the lobed family.
 * @function curve_gear_lobed(modul, tooth_number, width, bore, ...)
 * @brief Build a lobed non-circular gear.
 * @image ../images/functions/lobed/curve_gear_lobed.png Lobed gear preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param lobes {integer >= 2, default 4} Number of radial lobes.
 * @param lobe_depth {0 < depth < 0.5, default 0.13} Normalised lobe amplitude.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_lobed_body
 * @example c
 * curve_gear_lobed(1, 24, 4, 8);
 */
include <base.scad>

module _cg_lobed_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_lobed_build(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false)
 * @brief Internal lobed construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param lobes {integer, default 4} Internal construction parameter.
 * @param lobe_depth {number, default 0.13} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(lobes >= 2 && floor(lobes)==lobes,"lobed_gear: lobes must be an integer >= 2");
    assert(lobe_depth > 0 && lobe_depth < 0.5,"lobed_gear: lobe_depth must satisfy 0 < lobe_depth < 0.5");

    unit_points=_cg_lobed_unit_points(lobes,lobe_depth,samples);
    scale=_cg_pitch_scale_from_points(modul,tooth_number,unit_points,_cg_pi);
    points=_cg_scale_points(scale,unit_points);

    _cg_assert_samples(samples);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

module curve_gear_lobed(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_lobed_build(modul,tooth_number,width,bore,lobes,lobe_depth,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_lobed_body(modul, tooth_number, width, bore, ...)
 * @brief Build the lobed body solid without teeth.
 * @image ../images/functions/lobed/curve_gear_lobed_body.png Lobed body preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param lobes {integer >= 2, default 4} Number of radial lobes.
 * @param lobe_depth {0 < depth < 0.5, default 0.13} Normalised lobe amplitude.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_lobed_body(1, 24, 4, 8);
 */
module curve_gear_lobed_body(modul,tooth_number,width,bore,lobes=4,lobe_depth=0.13,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_lobed_build(modul,tooth_number,width,bore,lobes,lobe_depth,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_lobed_2d
 * @brief Emit the complete lobed gear profile as 2D geometry.
 * @image ../images/functions/lobed/curve_gear_lobed_2d.png lobed 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param lobes {value} Same family-specific parameter as curve_gear_lobed.
 * @param lobe_depth {value} Same family-specific parameter as curve_gear_lobed.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_lobed.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_lobed.
 * @param backlash {value} Same family-specific parameter as curve_gear_lobed.
 * @param clearance {value} Same family-specific parameter as curve_gear_lobed.
 * @param samples {value} Same family-specific parameter as curve_gear_lobed.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_lobed_2d(0.8, 34, 4.8);
 */
module curve_gear_lobed_2d(modul, tooth_number, bore, lobes=4, lobe_depth=0.13, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_lobed_build(modul, tooth_number, 0, bore, lobes, lobe_depth, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_lobed_body_2d
 * @brief Emit the lobed body as 2D geometry with an optional signed outer-contour offset.
 * @image ../images/functions/lobed/curve_gear_lobed_body_2d.png lobed 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param lobes {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param lobe_depth {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param samples {value} Same family-specific parameter as curve_gear_lobed_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_lobed_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_lobed_body_2d(modul, tooth_number, bore, lobes=4, lobe_depth=0.13, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_lobed_build(modul, tooth_number, 0, bore, lobes, lobe_depth, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
