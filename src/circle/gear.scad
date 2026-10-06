include <base.scad>

/***
 * @function curve_gear_circle(modul, tooth_number, width, bore, ...)
 * @brief Build a circular reference gear.
 * @image ../images/functions/circle/curve_gear_circle.png Circle gear preview
 * @image ../images/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Circular pitch-curve sampling density.
 */
module curve_gear_circle(modul,tooth_number,width,bore,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480) {
    _cg_assert_samples(samples,"circle_gear: samples must be an integer >= 120");
    _cg_gear_from_pitch_points(_cg_circle_points(modul,tooth_number,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,false);
}

/***
 * @function curve_gear_circle_body(modul, tooth_number, width, bore, samples=480)
 * @brief Build the circular reference body without teeth.
 * @image ../images/functions/circle/curve_gear_circle_body.png Circle body preview
 * @image ../images/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param samples {integer >= 120, default 480} Circular pitch-curve sampling density.
 */
module curve_gear_circle_body(modul,tooth_number,width,bore,samples=480) {
    _cg_assert_samples(samples,"circle_gear_body: samples must be an integer >= 120");
    _cg_gear_from_pitch_points(_cg_circle_points(modul,tooth_number,samples),modul,tooth_number,width,bore,20,0,false,undef,undef,true);
}


/***
 * @function curve_gear_circle_2d(modul, tooth_number, bore, ...)
 * @brief Emit the complete circular gear profile as 2D geometry.
 * @image ../images/functions/circle/curve_gear_circle_2d.png Circle 2D gear outline
 * @image ../images/table-spacer-512.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param pressure_angle {angle, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction.
 * @param clearance {undef or >= 0} Additional radial root clearance.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 * @example c
 * curve_gear_circle_2d(0.8, 34, 4.8);
 */
module curve_gear_circle_2d(modul,tooth_number,bore,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480) {
    _cg_assert_samples(samples,"circle_gear_2d: samples must be an integer >= 120");
    _cg_gear_2d_from_pitch_points(_cg_circle_points(modul,tooth_number,samples),modul,tooth_number,bore,pressure_angle,tooth_phase,false,backlash,clearance,false);
}

/***
 * @function curve_gear_circle_body_2d(modul, tooth_number, bore, samples=480, body_offset=0)
 * @brief Emit the circular body as 2D geometry; negative body_offset shrinks its outer contour.
 * @image ../images/functions/circle/curve_gear_circle_body_2d.png Circle 2D body outline
 * @image ../images/table-spacer-512.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 * @param body_offset {number, default 0} Signed outer-contour offset in mm; the bore is preserved.
 * @example c
 * curve_gear_circle_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_circle_body_2d(modul,tooth_number,bore,samples=480,body_offset=0) {
    _cg_assert_samples(samples,"circle_gear_body_2d: samples must be an integer >= 120");
    _cg_gear_2d_from_pitch_points(_cg_circle_points(modul,tooth_number,samples),modul,tooth_number,bore,20,0,false,undef,undef,true,undef,body_offset);
}
