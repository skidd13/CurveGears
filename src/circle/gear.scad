include <base.scad>

/***
 * @function curve_gear_circle
 * @brief Build a circular reference gear.
 * @image ../images/functions/circle/curve_gear_circle.png Circle gear preview
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
    assert(samples >= 120 && floor(samples)==samples,"circle_gear: samples must be an integer >= 120");
    _cg_gear_from_pitch_points(_cg_circle_points(modul,tooth_number,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,false);
}

/***
 * @function curve_gear_circle_body
 * @brief Build the circular reference body without teeth.
 * @image ../images/functions/circle/curve_gear_circle_body.png Circle body preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param samples {integer >= 120, default 480} Circular pitch-curve sampling density.
 */
module curve_gear_circle_body(modul,tooth_number,width,bore,samples=480) {
    assert(samples >= 120 && floor(samples)==samples,"circle_gear_body: samples must be an integer >= 120");
    _cg_gear_from_pitch_points(_cg_circle_points(modul,tooth_number,samples),modul,tooth_number,width,bore,20,0,false,undef,undef,true);
}
