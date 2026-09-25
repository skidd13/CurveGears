/***
 * @function curve_gear_ellipse_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated elliptical pair.
 * @image ../images/functions/ellipse/curve_gear_ellipse_pair.png Ellipse pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.62} Ellipse eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param samples {integer >= 120, default 480} Pitch-curve sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * Pair geometry uses the single-gear parameters documented in gear.scad.
  * @see curve_gear_ellipse
 * @example c
 * curve_gear_ellipse_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module _cg_ellipse_pair_build(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,samples=480,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
/***
 * @function _cg_ellipse_pair_build(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,samples=480,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")
 * @brief Internal ellipse pair construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param eccentricity {number, default 0.62} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param samples {integer, default 480} Pitch-curve or motion-table sampling density.
 * @param phase {number, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Use meshed placement when true, display placement otherwise.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param driver_color {string, default "SteelBlue"} Driver display colour.
 * @param mate_color {string, default "Gold"} Mate display colour.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    assert(eccentricity >= 0 && eccentricity < 1,"elliptical_gear_pair: eccentricity must satisfy 0 <= e < 1");
    axes=_cg_ellipse_axes(modul,tooth_number,eccentricity);
    a=axes[0]; b=axes[1];
    assert(samples >= 120 && floor(samples)==samples,"elliptical_gear_pair: samples must be an integer >= 120");
    D=_cg_ellipse_centre_distance(a,b,samples);
    motion=_cg_ellipse_motion_table(a,b,D,samples);
    closure_error=motion[len(motion)-1][1]-360;
    assert(abs(closure_error) < 0.08,"elliptical_gear_pair: conjugate closure error too large");
    driver=[for(i=[0:samples-1]) _cg_ellipse_driver_point(a,b,360*i/samples)];
    mate=_cg_ellipse_mate_points_from_driver(a,b,D,samples);
    _cg_pair_assembly(D,motion,phase,together_built,max([for(p=driver) _cg_vlen(p)]),max([for(p=mate) _cg_vlen(p)]),modul,driver,mate,tooth_number,pressure_angle,tooth_phase,backlash,clearance) {
        color(driver_color) curve_gear_ellipse(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_ellipse_mate(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}

module curve_gear_ellipse_pair(modul,tooth_number,width,bore,eccentricity=0.62,pressure_angle=20,samples=480,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_ellipse_pair_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
