include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/***
 * @function curve_gear_superformula_mate
 * @brief Build the standalone superformula mate boundary at the origin.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/superformula/curve_gear_superformula_mate.png Superformula mate 1
 * @image ../images/functions/superformula/curve_gear_superformula_mate_alternative.png Superformula mate 2
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
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 */
module curve_gear_superformula_mate(modul,tooth_number,width,bore,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=360) {
    assert(symmetry >= 2 && floor(symmetry)==symmetry,"superformula_gear_mate: symmetry must be an integer >= 2");
    assert(a>0 && b>0 && n1>0 && n2>0 && n3>0,"superformula_gear_mate: a,b,n1,n2,n3 must be positive");
    assert(_cg_superformula_odd_valid(symmetry,a,b,n2,n3),"superformula_gear_mate: odd symmetry requires a=b and n2=n3 for 360-degree continuity");
    _cg_assert_samples(samples,"superformula_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_superformula_shape(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/***
 * @function curve_gear_superformula_centre_distance
 * @brief Return the mathematical centre distance for a superformula pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_superformula_centre_distance(modul,tooth_number,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,samples=360) =
    _cg_polar_mate_distance(_cg_superformula_shape(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples),samples);

/***
 * @function curve_gear_superformula_mate_rotation
 * @brief Return the conjugate superformula mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param symmetry {integer >= 2, default 4} Number of repeated sectors.
 * @param a {number > 0, default 1} Superformula radial scale factor.
 * @param b {number > 0, default 1} Superformula radial scale factor.
 * @param n1 {number > 0, default 2.4} Superformula shape exponent.
 * @param n2 {number > 0, default 2.4} Superformula shape exponent.
 * @param n3 {number > 0, default 2.4} Superformula shape exponent.
 * @param samples {integer >= 120, default 360} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_superformula_mate_rotation(modul,tooth_number,symmetry=4,a=1,b=1,n1=2.4,n2=2.4,n3=2.4,samples=360,phase=0) =
    _cg_polar_mate_rotation(_cg_superformula_shape(modul,tooth_number,symmetry,a,b,n1,n2,n3,samples),samples,phase);
