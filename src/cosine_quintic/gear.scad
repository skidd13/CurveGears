include <base.scad>

module _cg_cosine_quintic_build(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
    assert(modul>0 && (is_2d || width>0) && bore>=0,"cosine_quintic_gear: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number,"cosine_quintic_gear: tooth_number must be an integer >= 3");
    assert(depth>0 && depth<.5 && harmonic>=1 && floor(harmonic)==harmonic,"cosine_quintic_gear: invalid curve parameters");
    _cg_assert_samples(samples,"cosine_quintic_gear: samples must be an integer >= 120");
    points=_cg_cosine_quintic_points(modul,tooth_number,samples,depth,harmonic);
    rotate([0,0,orientation])
        if(is_2d)
            _cg_gear_2d_from_pitch_points(points,modul,tooth_number,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only,undef,body_offset);
        else
            _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

/***
 * @function curve_gear_cosine_quintic
 * @brief Build a signed fifth-power cosine gear.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic.png Cosine Quintic gear preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.
 */
module curve_gear_cosine_quintic(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cosine_quintic_build(modul,tooth_number,width,bore,depth,harmonic,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/*** @function curve_gear_cosine_quintic_body
 * @brief Build the Cosine Quintic body.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_body.png Cosine Quintic body preview
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.
 */
module curve_gear_cosine_quintic_body(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cosine_quintic_build(modul,tooth_number,width,bore,depth,harmonic,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/*** @function curve_gear_cosine_quintic_2d
 * @brief Build the Cosine Quintic 2D outline.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_2d.png Cosine Quintic 2D outline
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation.
 */
module curve_gear_cosine_quintic_2d(modul,tooth_number,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_cosine_quintic_build(modul,tooth_number,0,bore,depth,harmonic,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false,true);
}

/*** @function curve_gear_cosine_quintic_body_2d
 * @brief Build the Cosine Quintic 2D body outline.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_body_2d.png Cosine Quintic 2D body outline
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param tooth_phase {number} Tooth phase. @param backlash {number} Backlash. @param clearance {number} Clearance. @param samples {integer} Samples. @param orientation {number} Orientation. @param body_offset {number} Body offset.
 */
module curve_gear_cosine_quintic_body_2d(modul,tooth_number,bore,depth=.19,harmonic=2,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_offset=0) {
    _cg_cosine_quintic_build(modul,tooth_number,0,bore,depth,harmonic,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true,true,body_offset);
}
