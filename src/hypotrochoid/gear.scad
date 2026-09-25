/***
 * @function curve_gear_hypotrochoid(modul, tooth_number, width, bore, ...)
 * @brief Build a hypotrochoid non-circular gear.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid.png Hypotrochoid gear preview
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

module _cg_hypotrochoid_build(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false) {
    assert(modul>0 && width>0 && bore>=0,"hypotrochoid: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"hypotrochoid: tooth number must be an integer >= 3");
    assert(major_ratio>rolling_ratio && rolling_ratio>0 && offset_ratio>0 && offset_ratio<rolling_ratio,"hypotrochoid: require major_ratio > rolling_ratio > 0 and 0 < offset_ratio < rolling_ratio");
    assert(samples>=120 && floor(samples)==samples,"hypotrochoid: samples must be an integer >= 120");
    unit_points=_cg_hypotrochoid_points(major_ratio,rolling_ratio,offset_ratio,samples);
    scale=_cg_trochoid_scale_from_points(modul,tooth_number,unit_points);
    points=_cg_trochoid_points_scaled_from_points(scale,unit_points);
    rotate([0,0,orientation]) _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

module curve_gear_hypotrochoid(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_hypotrochoid_build(modul,tooth_number,width,bore,major_ratio,rolling_ratio,offset_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/** @function curve_gear_hypotrochoid_body
 * @brief Build the hypotrochoid body solid without teeth.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_body.png Hypotrochoid body preview
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
