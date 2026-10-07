include <base.scad>

module _cg_temple_fay_build(modul,tooth_number,width,bore,wing=.24,fold=.07,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
    assert(modul>0 && (is_2d || width>0) && bore>=0,"temple_fay_gear: module, width and bore must be valid");
    assert(tooth_number>=3 && floor(tooth_number)==tooth_number && wing>0 && wing<.5 && fold>=0 && fold<.2,"temple_fay_gear: invalid parameters");
    _cg_assert_samples(samples,"temple_fay_gear: samples must be an integer >= 120");
    points=_cg_temple_fay_points(modul,tooth_number,samples,wing,fold);
    rotate([0,0,orientation]) if(is_2d) _cg_gear_2d_from_pitch_points(points,modul,tooth_number,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only,undef,body_offset); else _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

/***
 * @function curve_gear_temple_fay
 * @brief Build a Temple Fay butterfly-inspired gear.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay.png Temple Fay gear preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_temple_fay(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) { _cg_temple_fay_build(modul,tooth_number,width,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false); }

/*** @function curve_gear_temple_fay_body
 * @brief Build the Temple Fay body.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_body.png Temple Fay body preview
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_temple_fay_body(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) { _cg_temple_fay_build(modul,tooth_number,width,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true); }

/*** @function curve_gear_temple_fay_2d
 * @brief Build the Temple Fay 2D outline.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_2d.png Temple Fay 2D outline
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 */
module curve_gear_temple_fay_2d(modul,tooth_number,bore,wing=.18,fold=.05,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) { _cg_temple_fay_build(modul,tooth_number,0,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false,true); }

/*** @function curve_gear_temple_fay_body_2d
 * @brief Build the Temple Fay 2D body outline.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_body_2d.png Temple Fay 2D body outline
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param tooth_phase {number} Tooth phase.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param samples {integer} Samples.
 * @param orientation {number} Orientation.
 * @param body_offset {number} Body offset.
 */
module curve_gear_temple_fay_body_2d(modul,tooth_number,bore,wing=.18,fold=.05,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_offset=0) { _cg_temple_fay_build(modul,tooth_number,0,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true,true,body_offset); }
