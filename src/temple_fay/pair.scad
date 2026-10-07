include <mate.scad>
include <../common/pair/assembly.scad>

/*** @function curve_gear_temple_fay_pair
 * @brief Build a separated Temple Fay reference pair; this family is not asserted as a conjugate transmission.
 * @image ../images/functions/temple_fay/curve_gear_temple_fay_pair.png Temple Fay pair preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 *
 * @param modul {number} Tooth module.
 * @param tooth_number {integer} Tooth count.
 * @param width {number} Width.
 * @param bore {number} Bore.
 * @param wing {number} Wing amplitude.
 * @param fold {number} Fold harmonic.
 * @param pressure_angle {number} Pressure angle.
 * @param samples {integer} Samples.
 * @param phase {number} Pair phase.
 * @param together_built {boolean} Reference placement.
 * @param backlash {number} Backlash.
 * @param clearance {number} Clearance.
 * @param tooth_phase {number} Tooth phase.
 * @param driver_color {string} Driver colour.
 * @param mate_color {string} Mate colour.
 */
module curve_gear_temple_fay_pair(modul,tooth_number,width,bore,wing=.18,fold=.05,pressure_angle=20,samples=720,phase=0,together_built=false,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    points=_cg_temple_fay_points(modul,tooth_number,samples,wing,fold);
    extent=_cg_pair_point_extent(points);
    distance=curve_gear_temple_fay_centre_distance(modul,tooth_number,wing,fold,samples);
    _cg_static_pair_assembly(distance,together_built,phase,phase+180,extent,extent,modul) {
        color(driver_color) curve_gear_temple_fay(modul,tooth_number,width,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,phase);
        color(mate_color) curve_gear_temple_fay(modul,tooth_number,width,bore,wing,fold,pressure_angle,tooth_phase,backlash,clearance,samples,phase+180);
    }
}
