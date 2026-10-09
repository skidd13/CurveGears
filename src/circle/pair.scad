include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_circle_pair
 * @brief Build a meshed or separated circular reference pair.
 * @param modul {number > 0, default .8} Tooth module in mm.
 * @param tooth_number {integer >= 3, default 34} Number of teeth.
 * @param width {number > 0, default 4} Extrusion width in mm.
 * @param bore {number >= 0, default 4.8} Centre bore diameter in mm.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle in degrees.
 * @param samples {integer >= 120, default 480} Circular pitch-curve sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param backlash {undef or >= 0, default undef} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0, default undef} Additional radial root clearance in mm.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 */
module curve_gear_circle_pair(modul,tooth_number,width,bore,pressure_angle=20,samples=480,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"circle_gear_pair: samples must be an integer >= 120");
    radius=_cg_circle_radius(modul,tooth_number);
    distance=curve_gear_circle_centre_distance(modul,tooth_number);
    motion=[for(i=[0:samples]) [360*i/samples,360*i/samples]];
    points=_cg_circle_points(modul,tooth_number,samples);
    _cg_pair_assembly(distance,motion,phase,together_built,radius,radius,modul,points,points,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,false,false,driver_color,mate_color);
}
