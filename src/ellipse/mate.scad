include <gear.scad>
include <../common/mate/preparation.scad>
include <../common/mate/placement.scad>

/***
 * @function curve_gear_ellipse_mate(modul, tooth_number, width, bore, ...)
 * @brief Build the standalone elliptical mate boundary at the origin.
 * Alternative 2 uses the contrasting controls described in the gear example.
 * @image ../images/functions/ellipse/curve_gear_ellipse_mate.png Ellipse mate 1
 * @image ../images/functions/ellipse/curve_gear_ellipse_mate_alternative.png Ellipse mate 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 */
module curve_gear_ellipse_mate(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480) {
    assert(eccentricity >= 0 && eccentricity < 1,"elliptical_gear_mate: eccentricity must satisfy 0 <= e < 1");
    _cg_assert_samples(samples,"elliptical_gear_mate: samples must be an integer >= 120");
    _cg_polar_mate(_cg_ellipse_shape(modul,tooth_number,eccentricity,samples),modul,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,samples);
}

/***
 * @function curve_gear_ellipse_centre_distance(modul, tooth_number, eccentricity, ...)
 * @brief Return the mathematical centre distance for an elliptical pair.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param samples {integer >= 120, default 480} Motion-table sampling density.
 * @return {number} Pair centre distance in mm.
 */
function curve_gear_ellipse_centre_distance(modul,tooth_number,eccentricity=0.62,samples=480) =
    _cg_polar_mate_distance(_cg_ellipse_shape(modul,tooth_number,eccentricity,samples),samples);

/***
 * @function curve_gear_ellipse_mate_rotation(modul, tooth_number, eccentricity, ...)
 * @brief Return the conjugate elliptical mate rotation for a driver phase.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param samples {integer >= 120, default 480} Motion-table sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @return {angle} Mate rotation in degrees.
 */
function curve_gear_ellipse_mate_rotation(modul,tooth_number,eccentricity=0.62,samples=480,phase=0) =
    _cg_polar_mate_rotation(_cg_ellipse_shape(modul,tooth_number,eccentricity,samples),samples,phase);
