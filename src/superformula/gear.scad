/***
 * Public single-gear construction for the superformula family.
 * @function curve_gear_superformula
 * @brief Build a superformula non-circular gear.
 * A rounded square with symmetry 4 and exponents 8 replaces the canonical five-pointed star. This demonstrates the superformula's ability to change its shape class through exponents and symmetry.
 * @image ../images/functions/superformula/curve_gear_superformula.png Superformula gear 1
 * @image ../images/functions/superformula/curve_gear_superformula_alternative.png Superformula gear 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * Odd symmetry requires a=b and n2=n3 for full-turn continuity.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_superformula_body
 * @example c
 * curve_gear_superformula(1, 24, 4, 8);
 */
include <base.scad>

module _cg_superformula_build(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0,body_only=false,is_2d=false,body_offset=0) {
/***
 * @function _cg_superformula_build
 * @brief Internal superformula construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param symmetry {integer, default 4} Internal construction parameter.
 * @param a {value, default 1} Internal construction parameter.
 * @param b {value, default 1} Internal construction parameter.
 * @param n1 {value, default 2.4} Internal construction parameter.
 * @param n2 {value, default 2.4} Internal construction parameter.
 * @param n3 {value, default 2.4} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 720} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    assert(symmetry >= 2 && floor(symmetry)==symmetry,"superformula_gear: symmetry must be an integer >= 2");
    assert(a>0 && b>0 && n1>0 && n2>0 && n3>0,"superformula_gear: a,b,n1,n2,n3 must be positive");
    assert(_cg_superformula_odd_valid(symmetry,a,b,n2,n3),"superformula_gear: odd symmetry requires a=b and n2=n3 for 360-degree continuity");

    shape=_cg_superformula_shape(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples);
    points=shape[0];

    _cg_assert_samples(samples);
    rotate([0,0,orientation]) {
        if (is_2d)
            _cg_gear_2d_from_pitch_points(points, modul, tooth_number, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only, undef, body_offset);
        else
            _cg_gear_from_pitch_points(points, modul, tooth_number, width, bore, pressure_angle, tooth_phase, false, backlash, clearance, body_only);
    }
}

module curve_gear_superformula(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_superformula_build(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_superformula_body
 * @brief Build the superformula body solid without teeth.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/superformula/curve_gear_superformula_body.png Superformula body 1
 * @image ../images/functions/superformula/curve_gear_superformula_body_alternative.png Superformula body 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 720} Curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_superformula_body(1, 24, 4, 8);
 */
module curve_gear_superformula_body(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=720,orientation=0) {
    _cg_superformula_build(modul,tooth_number,width,bore,symmetry,a,b,n1,n2,n3,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}

/***
 * @function curve_gear_superformula_2d
 * @brief Emit the complete superformula gear profile as 2D geometry.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/superformula/curve_gear_superformula_2d.png Superformula 2D gear 1
 * @image ../images/functions/superformula/curve_gear_superformula_alternative_2d.png Superformula 2D gear 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param symmetry {value} Same family-specific parameter as curve_gear_superformula.
 * @param a {value} Same family-specific parameter as curve_gear_superformula.
 * @param b {value} Same family-specific parameter as curve_gear_superformula.
 * @param n1 {value} Same family-specific parameter as curve_gear_superformula.
 * @param n2 {value} Same family-specific parameter as curve_gear_superformula.
 * @param n3 {value} Same family-specific parameter as curve_gear_superformula.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_superformula.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_superformula.
 * @param backlash {value} Same family-specific parameter as curve_gear_superformula.
 * @param clearance {value} Same family-specific parameter as curve_gear_superformula.
 * @param samples {value} Same family-specific parameter as curve_gear_superformula.
 * @param orientation {value} Rotation in degrees.
 * @example c
 * curve_gear_superformula_2d(0.8, 34, 4.8);
 */
module curve_gear_superformula_2d(modul, tooth_number, bore, symmetry=4, a=1, b=1, n1=2.4, n2=2.4, n3=2.4, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0) {
    _cg_superformula_build(modul, tooth_number, 0, bore, symmetry, a, b, n1, n2, n3, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, false, true, 0);
}

/***
 * @function curve_gear_superformula_body_2d
 * @brief Emit the superformula body as 2D geometry with an optional signed outer-contour offset.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/superformula/curve_gear_superformula_body_2d.png Superformula 2D body 1
 * @image ../images/functions/superformula/curve_gear_superformula_body_alternative_2d.png Superformula 2D body 2
 * @param modul {value} Tooth module in mm.
 * @param tooth_number {value} Number of teeth.
 * @param bore {value} Centre bore diameter in mm.
 * @param symmetry {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param a {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param b {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param n1 {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param n2 {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param n3 {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param pressure_angle {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param tooth_phase {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param backlash {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param clearance {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param samples {value} Same family-specific parameter as curve_gear_superformula_body.
 * @param orientation {value} Rotation in degrees.
 * @param body_offset {value} Signed offset in mm; negative values shrink the outer body contour while preserving the bore.
 * @example c
 * curve_gear_superformula_body_2d(0.8, 34, 4.8, body_offset=-2);
 */
module curve_gear_superformula_body_2d(modul, tooth_number, bore, symmetry=4, a=1, b=1, n1=2.4, n2=2.4, n3=2.4, pressure_angle=20, tooth_phase=0, backlash=undef, clearance=undef, samples=720, orientation=0, body_offset=0) {
    _cg_superformula_build(modul, tooth_number, 0, bore, symmetry, a, b, n1, n2, n3, pressure_angle, tooth_phase, backlash, clearance, samples, orientation, true, true, body_offset);
}
