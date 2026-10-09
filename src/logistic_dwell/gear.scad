include <base.scad>

module _cg_logistic_dwell_build(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
    assert(modul>0 && (is_2d || width>0) && bore>=0,"logistic_dwell_gear: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"logistic_dwell_gear: tooth_number must be an integer >= 3");
    assert(_cg_logistic_dwell_parameters_valid(gain,depth),"logistic_dwell_gear: invalid curve parameters");
    _cg_assert_samples(samples,"logistic_dwell_gear: samples must be an integer >= 120");
    points=_cg_logistic_dwell_shape(modul,tooth_number,gain,depth,samples)[0];
    _cg_curve_gear(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only,orientation,is_2d,body_offset);
}

/***
 * @function curve_gear_logistic_dwell
 * @brief Build a logistic-gated second-harmonic dwell gear.
 * Depth 0.46 and gain 3 replace the canonical shallow, steep logistic gate. The larger radial variation and smoother transitions distinguish curve amplitude from gate sharpness; coarse teeth expose the contour.
 *
 * @param modul {number > 0} Tooth module in mm.
 *
 * @param tooth_number {integer >= 3} Number of teeth.
 *
 * @param width {number > 0} Extrusion width in mm.
 *
 * @param bore {number >= 0} Centre bore diameter in mm.
 *
 * @param gain {number > 0, default 8} Logistic transition gain.
 *
 * @param depth {0 < number < 0.5, default 0.2} Radial dwell depth.
 *
 * @param pressure_angle {angle, default 20} Pressure angle.
 *
 * @param tooth_phase {angle, default 0} Tooth phase.
 *
 * @param backlash {undef or >= 0} Backlash.
 *
 * @param clearance {undef or >= 0} Clearance.
 *
 * @param samples {integer >= 120, default 720} Samples.
 *
 * @param orientation {angle, default 0} Orientation.
 */
module curve_gear_logistic_dwell(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_logistic_dwell_build(modul,tooth_number,width,bore,gain,depth,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/*** @function curve_gear_logistic_dwell_body
 * @brief Build the Logistic Dwell body.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param gain {number} Logistic gain.
 * @param depth {number} Dwell depth.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_logistic_dwell_body(modul,tooth_number,width,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_logistic_dwell_build(modul,tooth_number,width,bore,gain,depth,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/*** @function curve_gear_logistic_dwell_2d
 * @brief Build the Logistic Dwell 2D outline.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param bore {number} Bore.
 * @param gain {number} Logistic gain.
 * @param depth {number} Dwell depth.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_logistic_dwell_2d(modul,tooth_number,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_logistic_dwell_build(modul,tooth_number,0,bore,gain,depth,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false,true);
}

/*** @function curve_gear_logistic_dwell_body_2d
 * @brief Build the Logistic Dwell 2D body outline.
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param bore {number} Bore.
 * @param gain {number} Logistic gain.
 * @param depth {number} Dwell depth.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 * @param body_offset {number} Body offset.
 */
module curve_gear_logistic_dwell_body_2d(modul,tooth_number,bore,gain=8,depth=.2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_offset=0) {
    _cg_logistic_dwell_build(modul,tooth_number,0,bore,gain,depth,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true,true,body_offset);
}
