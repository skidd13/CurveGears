/***
 * Public single-gear construction for the logarithmic spiral family.
 * @function curve_gear_logarithmic_spiral(modul, tooth_number, width, bore, ...)
 * @brief Build a logarithmic-spiral non-circular gear.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral.png Logarithmic spiral gear preview
 * @image ../images/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3 and divisible by sectors} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param sectors {integer >= 1, default 1} Number of repeated spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Spiral sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_logarithmic_spiral_body
 * @example c
 * curve_gear_logarithmic_spiral(1, 24, 4, 8);
 */
include <base.scad>

module _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0,body_only=false)
 * @brief Dispatch logarithmic-spiral construction, building its spiral and radial returns as one canonical 2D boundary; long return segments form inaccessible tooth corridors, so ordinary teeth are omitted there.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param sectors {integer, default 1} Internal construction parameter.
 * @param growth_rate {number, default 1.17} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 360} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(sectors >= 1 && floor(sectors)==sectors,"logarithmic_spiral_gear: sectors must be an integer >= 1");
    assert(tooth_number >= 3 && floor(tooth_number)==tooth_number,"logarithmic_spiral_gear: tooth_number must be an integer >= 3");
    assert(tooth_number % sectors == 0,"logarithmic_spiral_gear: tooth_number must be divisible by sectors");
    assert(growth_rate > 1,"logarithmic_spiral_gear: growth_rate must be > 1");

    rmin=_cg_logspiral_rmin(modul,tooth_number,sectors,growth_rate);

    _cg_assert_samples(samples);
    points=_cg_logspiral_pitch_points(rmin,growth_rate,sectors,samples);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, true, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, true, backlash, clearance, body_only);
    }
}

module curve_gear_logarithmic_spiral(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0) {
    _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_logarithmic_spiral_body(modul, tooth_number, width, bore, ...)
 * @brief Build the logarithmic-spiral body solid without teeth.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body.png Logarithmic spiral body preview
 * @image ../images/table-spacer.png ⠀
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param sectors {integer >= 1, default 1} Number of repeated spiral sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 360} Spiral sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_logarithmic_spiral_body(1, 24, 4, 8);
 */
module curve_gear_logarithmic_spiral_body(modul,tooth_number,width,bore,sectors=1,growth_rate=1.17,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360,orientation=0) {
    _cg_logarithmic_spiral_build(modul,tooth_number,width,bore,sectors,growth_rate,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_logarithmic_spiral_2d
 * @brief Emit the complete logarithmic_spiral gear profile as 2D geometry.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_2d.png logarithmic_spiral 2D gear outline
 * @image ../images/table-spacer-512.png ⠀
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param sectors {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param growth_rate {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param backlash {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param clearance {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param samples {value} Same family-specific parameter as curve_gear_logarithmic_spiral.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_logarithmic_spiral_2d(0.8, 34, 4.8);
 */
module curve_gear_logarithmic_spiral_2d(modul, tooth_number, bore, sectors=1, growth_rate=1.17, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=360, orientation=0) {
    _cg_logarithmic_spiral_build(modul, tooth_number, 0, bore, sectors, growth_rate, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_logarithmic_spiral_body_2d
 * @brief Emit the logarithmic_spiral body as 2D geometry with an optional signed outer-contour offset.
 * @image ../images/functions/logarithmic_spiral/curve_gear_logarithmic_spiral_body_2d.png logarithmic_spiral 2D body outline
 * @image ../images/table-spacer-512.png ⠀
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param sectors {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param growth_rate {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param samples {value} Same family-specific parameter as curve_gear_logarithmic_spiral_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_logarithmic_spiral_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_logarithmic_spiral_body_2d(modul, tooth_number, bore, sectors=1, growth_rate=1.17, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=360, orientation=0, body_offset=0) {
    _cg_logarithmic_spiral_build(modul, tooth_number, 0, bore, sectors, growth_rate, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
