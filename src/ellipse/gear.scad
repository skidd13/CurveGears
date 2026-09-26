/***
 * Public single-gear construction for the ellipse family.
 * @function curve_gear_ellipse(modul, tooth_number, width, bore, ...)
 * @brief Build an elliptical non-circular gear.
 * @image ../images/functions/ellipse/curve_gear_ellipse.png Ellipse gear preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity; zero is circular.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * The gear is centred on X=0,Y=0 with its lower face at Z=0.
  * @see curve_gear_ellipse_body
 * @example c
 * curve_gear_ellipse(1, 24, 4, 8);
 */
include <base.scad>

module _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0,body_only=false) {
/***
 * @function _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0,body_only=false)
 * @brief Internal ellipse construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param eccentricity {number, default 0.62} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param samples {integer, default 480} Pitch-curve or motion-table sampling density.
 * @param orientation {number, default 0} Single-gear display rotation in degrees.
 * @param body_only {boolean, default false} Emit the body without teeth.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    assert(eccentricity >= 0 && eccentricity < 1,"elliptical_gear: eccentricity must satisfy 0 <= e < 1");
    axes=_cg_ellipse_axes(modul,tooth_number,eccentricity);
    a=axes[0]; b=axes[1];
    points=[for(i=[0:samples-1]) _cg_ellipse_driver_point(a,b,360*i/samples)];

    _cg_assert_samples(samples);
    // Drawing
    rotate([0,0,orientation]) _cg_gear_from_pitch_points(points,modul,tooth_number,width,bore,pressure_angle,tooth_phase,false,backlash,clearance,body_only);
}

// Single gear; mm dimensions, degree angles, Z=0 lower face.
module curve_gear_ellipse(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0) {
    _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,false);
}

/***
 * @function curve_gear_ellipse_body(modul, tooth_number, width, bore, ...)
 * @brief Build the elliptical body solid without teeth.
 * @image ../images/functions/ellipse/curve_gear_ellipse_body.png Ellipse body preview
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
 * @param orientation {angle, default 0} Single-gear display rotation in degrees.
 * @example c
 * curve_gear_ellipse_body(1, 24, 4, 8);
 */
// Body solid without teeth.
module curve_gear_ellipse_body(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,tooth_phase=0,backlash=undef,clearance=undef,samples=480,orientation=0) {
    _cg_ellipse_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples,orientation,true);
}
