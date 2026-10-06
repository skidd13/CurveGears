include <base.scad>

module _cg_tanh_triad_build(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
    assert(modul>0 && (is_2d || width>0) && bore>=0,"tanh_triad_gear: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"tanh_triad_gear: tooth_number must be an integer >= 3");
    assert(transition>0 && crest>0 && crest<.5 && correction>=0 && correction<.2,"tanh_triad_gear: invalid curve parameters");
    _cg_assert_samples(samples,"tanh_triad_gear: samples must be an integer >= 120");
    points=_cg_tanh_triad_points(modul,tooth_number,samples,transition,crest,correction);
    rotate([0,0,orientation])
        if(is_2d)
            _cg_gear_2d_from_pitch_points(points,modul,tooth_number,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only,undef,body_offset);
        else
            _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

/**
 * @function curve_gear_tanh_triad
 * @brief Build a bounded tanh-modulated three-cycle gear.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad.png Tanh Triad gear preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param transition {number > 0, default 1.8} Transition steepness.
 * @param crest {0 < number < 0.5, default 0.13} Main radial modulation.
 * @param correction {0 <= number < 0.2, default 0.03} Sixth-harmonic correction.
 * @param pressure_angle {angle, default 20} Pressure angle. @param tooth_phase {angle, default 0} Tooth phase. @param backlash {undef or >= 0} Backlash. @param clearance {undef or >= 0} Clearance. @param samples {integer >= 120, default 720} Samples. @param orientation {angle, default 0} Orientation.
 */
module curve_gear_tanh_triad(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_tanh_triad_build(modul,tooth_number,width,bore,transition,crest,correction,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_tanh_triad_body
 * @brief Build the tanh-modulated gear body.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_body.png Tanh Triad body preview
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param transition {number} Transition.
 * @param crest {number} Crest.
 * @param correction {number} Correction.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_tanh_triad_body(modul,tooth_number,width,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_tanh_triad_build(modul,tooth_number,width,bore,transition,crest,correction,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_tanh_triad_2d
 * @brief Build the tanh-modulated 2D gear outline.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_2d.png Tanh Triad 2D outline
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param bore {number} Bore.
 * @param transition {number} Transition.
 * @param crest {number} Crest.
 * @param correction {number} Correction.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_tanh_triad_2d(modul,tooth_number,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_tanh_triad_build(modul,tooth_number,0,bore,transition,crest,correction,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false,true);
}

/***
 * @function curve_gear_tanh_triad_body_2d
 * @brief Build the tanh-modulated 2D body outline.
 * @image ../images/functions/tanh_triad/curve_gear_tanh_triad_body_2d.png Tanh Triad 2D body outline
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param bore {number} Bore.
 * @param transition {number} Transition.
 * @param crest {number} Crest.
 * @param correction {number} Correction.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 * @param body_offset {number} Body offset.
 */
module curve_gear_tanh_triad_body_2d(modul,tooth_number,bore,transition=1.8,crest=.13,correction=.03,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_offset=0) {
    _cg_tanh_triad_build(modul,tooth_number,0,bore,transition,crest,correction,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true,true,body_offset);
}
