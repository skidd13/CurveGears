/***
 * @function curve_gear_pascal_pair(modul, tooth_number, width, bore, ...)
 * @brief Build a meshed or separated Pascal pair.
 * @image ../images/functions/pascal/curve_gear_pascal_pair.png Pascal pair preview
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param eccentricity {0 <= e < 1, default 0.25} Pascal eccentricity.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param samples {integer >= 120, default 360} Pitch-curve sampling density.
 * @param phase {angle, default 0} Pair motion phase in degrees.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param experimental_nonconvex {boolean, default false} Permit e >= 0.5 and use the direct calculated mate boundary.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 * Pair geometry uses the single-gear parameters documented in gear.scad.
  * @see curve_gear_pascal
 * @example c
 * curve_gear_pascal_pair(1, 24, 4, 8);
 */
include <mate.scad>
include <../pair/assembly.scad>

module _cg_pascal_pair_build(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,samples=360,phase=0,together_built=true,experimental_nonconvex=false,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
/***
 * @function _cg_pascal_pair_build(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,samples=360,phase=0,together_built=true,experimental_nonconvex=false,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold")
 * @brief Internal pascal pair construction dispatcher.
 * @param modul {number} Tooth module in mm.
 * @param tooth_number {integer} Number of teeth.
 * @param width {number} Extrusion width in mm.
 * @param bore {number} Centre bore diameter in mm.
 * @param eccentricity {number, default 0.25} Internal construction parameter.
 * @param pressure_angle {number, default 20} Involute pressure angle in degrees.
 * @param samples {integer, default 360} Pitch-curve or motion-table sampling density.
 * @param phase {number, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Use meshed placement when true, display placement otherwise.
 * @param experimental_nonconvex {boolean, default false} Internal construction parameter.
 * @param backlash {number, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {number, default undef} Additional radial root clearance in mm.
 * @param tooth_phase {number, default 0} Tooth placement phase in degrees.
 * @param driver_color {string, default "SteelBlue"} Driver display colour.
 * @param mate_color {string, default "Gold"} Mate display colour.
 * @return {geometry} Constructed family geometry.
 */
    // Dimension Calculations
    assert(eccentricity >= 0 && eccentricity < 1,"pascal_gear_pair: eccentricity must satisfy 0 <= eccentricity < 1");
    assert(eccentricity < 0.5 || experimental_nonconvex,"pascal_gear_pair: eccentricity >= 0.5 requires experimental_nonconvex=true");
    assert(samples >= 120 && floor(samples)==samples,"pascal_gear_pair: samples must be an integer >= 120");
    scale=_cg_pascal_scale(modul,tooth_number,eccentricity,samples);
    min_r=_cg_pascal_min_radius(scale,eccentricity);
    if(bore > 0)
        assert(min_r > bore/2,"pascal_gear_pair: bore exceeds the minimum driver pitch radius; reduce bore or eccentricity");
    mx=_cg_pascal_max_radius(scale,eccentricity);
    D=_cg_solve_mate_distance(_cg_pascal_motion_radii(scale,eccentricity,samples),mx+.01,4*mx);
    motion=_cg_pascal_motion_table(scale,eccentricity,D,samples);
    closure_error=motion[len(motion)-1][1]-360;
    assert(abs(closure_error) < 0.08,"pascal_gear_pair: conjugate closure error too large");
    driver=_cg_pascal_points(scale,eccentricity,samples);
    mate=_cg_pascal_mate_points_from_driver(scale,eccentricity,D,samples);
    radial_root=_cg_pascal_requires_radial_root(eccentricity);

    if(eccentricity >= 0.5)
        echo("pascal_gear_pair: non-convex Pascal pair uses the direct calculated mate boundary; dense validation is required for new parameter sets");

    _cg_pair_assembly(D,motion,phase,together_built,max([for(p=driver) _cg_vlen(p)]),max([for(p=mate) _cg_vlen(p)]),modul,driver,mate,tooth_number,pressure_angle,tooth_phase,backlash,clearance) {
        color(driver_color) curve_gear_pascal(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples);
        color(mate_color) curve_gear_pascal_mate(modul,tooth_number,width,bore,eccentricity,pressure_angle,tooth_phase,backlash,clearance,samples);
    }
}

module curve_gear_pascal_pair(modul,tooth_number,width,bore,eccentricity=0.25,pressure_angle=20,samples=360,phase=0,together_built=true,experimental_nonconvex=false,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_pascal_pair_build(modul,tooth_number,width,bore,eccentricity,pressure_angle,samples,phase,together_built,experimental_nonconvex,backlash,clearance,tooth_phase,driver_color,mate_color);
}
