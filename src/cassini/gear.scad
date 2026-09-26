/***
 * @function curve_gear_cassini
 * @brief Build a single-loop Cassini non-circular gear.
 * @image ../images/functions/cassini/curve_gear_cassini.png Cassini gear preview
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

module _cg_cassini_build(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false) {
    assert(_cg_cassini_focus_ratio_valid(focus_ratio),"cassini_gear: focus_ratio must satisfy 0 <= focus_ratio < 1");
    _cg_assert_samples(samples,"cassini_gear: samples must be an integer >= 120");
    unit_points=_cg_cassini_points(1,focus_ratio,samples);
    scale=_cg_pitch_scale_from_points(modul,tooth_number,unit_points,_cg_pi);
    points=_cg_scale_points(scale,unit_points);
    rotate([0,0,orientation]) _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

module curve_gear_cassini(modul,tooth_number,width,bore,focus_ratio=.78,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cassini_build(modul,tooth_number,width,bore,focus_ratio,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/**
 * @function curve_gear_cassini_body
 * @brief Build the Cassini body solid without teeth.
 * @image ../images/functions/cassini/curve_gear_cassini_body.png Cassini body preview
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
