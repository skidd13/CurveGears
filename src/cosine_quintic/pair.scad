include <mate.scad>
include <../common/pair/assembly.scad>

/***
 * @function curve_gear_cosine_quintic_pair
 * @brief Build a Cosine Quintic gear pair.
 * @image ../images/functions/cosine_quintic/curve_gear_cosine_quintic_pair.png Cosine Quintic pair preview
 * @param modul {number} Tooth module. @param tooth_number {integer} Tooth count. @param width {number} Width. @param bore {number} Bore. @param depth {number} Quintic depth. @param harmonic {integer} Cosine harmonic. @param pressure_angle {number} Pressure angle. @param samples {integer} Samples. @param phase {number} Pair phase. @param together_built {boolean} Mesh pair. @param backlash {number} Backlash. @param clearance {number} Clearance. @param tooth_phase {number} Tooth phase. @param driver_color {string} Driver colour. @param mate_color {string} Mate colour.
 */
module curve_gear_cosine_quintic_pair(modul,tooth_number,width,bore,depth=.19,harmonic=2,pressure_angle=20,samples=720,phase=0,together_built=true,backlash=undef,clearance=undef,tooth_phase=0,driver_color="SteelBlue",mate_color="Gold") {
    _cg_assert_samples(samples,"cosine_quintic_gear_pair: samples must be an integer >= 120");
    unit_points=_cg_cosine_quintic_unit_points(samples,depth,harmonic);
    scale=_cg_cosine_quintic_scale(modul,tooth_number,samples,depth,harmonic,unit_points);
    driver=_cg_scale_points(scale,unit_points);
    driver_radii=_cg_cosine_quintic_driver_radii(scale,depth,harmonic,samples);
    mid_radii=_cg_cosine_quintic_motion_radii(scale,depth,harmonic,samples);
    D=_cg_cosine_quintic_centre_distance(scale,depth,harmonic,samples);
    state=_cg_motion_integration_state(driver_radii,mid_radii,D);
    motion=state[2];
    mate=_cg_mate_points_from_radius_samples_with_state(driver_radii,D,state);
    _cg_pair_assembly(D,motion,phase,together_built,_cg_pair_point_extent(driver),_cg_pair_point_extent(mate),modul,driver,mate,tooth_number,width,bore,pressure_angle,tooth_phase,backlash,clearance,false,false,driver_color,mate_color);
}
