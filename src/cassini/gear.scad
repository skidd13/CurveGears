/***
 * @function curve_gear_cassini
 * @brief Build a single-loop Cassini non-circular gear.
 * @image ../images/functions/cassini/curve_gear_cassini.png Cassini gear preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param focus_ratio {0 <= number < 1, default 0.78} Focal half-distance divided by the Cassini product parameter.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation.
 * The supported branch is a positive single loop. `focus_ratio >= 1` is rejected.
 * @example c
 * curve_gear_cassini(1, 24, 4, 8);
 */
include <base.scad>

/***
 * @function _cg_cassini_build(modul, tooth_number, width, bore, focus_ratio=0.78, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_only=false)
 * @brief Construct a validated Cassini body, gear, or mate boundary.
 * @param modul {number > 0} Tooth module in millimetres.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in millimetres.
 * @param bore {number >= 0} Centre bore diameter in millimetres.
 * @param focus_ratio {0 <= number < 1, default 0.78} Cassini focal ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 120, default 720} Pitch-curve sample count.
 * @param orientation {angle, default 0} Display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 */
module _cg_cassini_build(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
    assert(_cg_cassini_focus_ratio_valid(focus_ratio),"cassini_gear: focus_ratio must satisfy 0 <= focus_ratio < 1");
    _cg_assert_samples(samples,"cassini_gear: samples must be an integer >= 120");
    unit_points=_cg_cassini_points(1,focus_ratio,samples);
    scale=_cg_pitch_scale_from_points(modul,tooth_number,unit_points,_cg_pi);
    points=_cg_scale_points(scale,unit_points);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

module curve_gear_cassini(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cassini_build(modul,tooth_number,width,bore,focus_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/**
 * @function curve_gear_cassini_body
 * @brief Build the Cassini body solid without teeth.
 * @image ../images/functions/cassini/curve_gear_cassini_body.png Cassini body preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param focus_ratio {0 <= number < 1, default 0.78} Focal half-distance divided by the Cassini product parameter.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation.
 * @example c
 * curve_gear_cassini_body(1, 24, 4, 8);
 */
module curve_gear_cassini_body(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cassini_build(modul,tooth_number,width,bore,focus_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_cassini_2d
 * @brief Emit the complete cassini gear profile as 2D geometry.
 * @image ../images/functions/cassini/curve_gear_cassini_2d.png cassini 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param focus_ratio {value} Same family-specific parameter as curve_gear_cassini.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_cassini.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_cassini.
 * @param backlash {value} Same family-specific parameter as curve_gear_cassini.
 * @param clearance {value} Same family-specific parameter as curve_gear_cassini.
 * @param samples {value} Same family-specific parameter as curve_gear_cassini.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_cassini_2d(0.8, 34, 4.8);
 */
module curve_gear_cassini_2d(modul, tooth_number, bore, focus_ratio=.78, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_cassini_build(modul, tooth_number, 0, bore, focus_ratio, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_cassini_body_2d
 * @brief Emit the cassini body as 2D geometry with an optional signed outer-contour offset.
 * @image ../images/functions/cassini/curve_gear_cassini_body_2d.png cassini 2D body outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param focus_ratio {value} Same family-specific parameter as curve_gear_cassini_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_cassini_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_cassini_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_cassini_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_cassini_body.
 * @param samples {value} Same family-specific parameter as curve_gear_cassini_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_cassini_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_cassini_body_2d(modul, tooth_number, bore, focus_ratio=.78, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_cassini_build(modul, tooth_number, 0, bore, focus_ratio, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
