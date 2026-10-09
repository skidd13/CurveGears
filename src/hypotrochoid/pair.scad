/**
 * @function curve_gear_hypotrochoid_pair
 * @brief Build a meshed or separated hypotrochoid driver/mate pair.
 *
 * The separated display alternative uses `together_built=false`; its curated
 * scenario example lives beside the public pair example.
 * Alternative 2 separates the driver and mate and uses the contrasting gear controls described above.
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair.png Hypotrochoid pair 1
 * @image ../images/functions/hypotrochoid/curve_gear_hypotrochoid_pair_alternative.png Hypotrochoid pair 2
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param width {number > 0} Extrusion width in mm.
 * @param bore {number >= 0} Centre bore diameter in mm.
 * @param major_ratio {number > rolling_ratio, default 3} Fixed-to-rolling circle ratio.
 * @param rolling_ratio {number > 0, default 1} Rolling-circle ratio.
 * @param offset_ratio {0 < offset < rolling_ratio, default 0.35} Pen offset ratio.
 * @param pressure_angle {0 < angle < 90, default 20} Involute pressure angle.
 * @param samples {integer >= 120, default 720} Pitch-curve sampling density.
 * @param phase {angle, default 0} Driver motion phase in degrees.
 * @param together_built {boolean, default true} Place the pair meshed when true, separated when false.
 * @param backlash {undef or >= 0} Tangential tooth-thickness reduction in mm.
 * @param clearance {undef or >= 0} Additional radial root clearance in mm.
 * @param tooth_phase {angle, default 0} Tooth placement phase in degrees.
 * @param driver_color {OpenSCAD colour, default SteelBlue} Driver display colour.
 * @param mate_color {OpenSCAD colour, default Gold} Mate display colour.
 */
include <mate.scad>
include <../common/pair/assembly.scad>

module curve_gear_hypotrochoid_pair(modul,tooth_number,width,bore,major_ratio=3,rolling_ratio=1,offset_ratio=.35,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    assert(major_ratio > rolling_ratio && rolling_ratio > 0 && offset_ratio > 0 && offset_ratio < rolling_ratio,"hypotrochoid: require major_ratio > rolling_ratio > 0 and 0 < offset_ratio < rolling_ratio");
    _cg_assert_samples(samples,"hypotrochoid pair: samples must be an integer >= 120");
    shape=_cg_hypotrochoid_shape(modul,tooth_number,major_ratio,rolling_ratio,offset_ratio,samples);
    _cg_polar_pair(shape,modul,tooth_number,width,bore,pressure_angle,samples,phase,together_built,backlash,clearance,tooth_phase,driver_color,mate_color);
}
