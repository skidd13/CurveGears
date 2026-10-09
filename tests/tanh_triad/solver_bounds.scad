/***
 * @function tanh_triad_solver_bounds
 * @brief Retain an exterior solver bracket when the corrective harmonic exceeds the crest estimate.
 * Source: [`tanh_triad/solver_bounds.scad`](tanh_triad/solver_bounds.scad)
 */
include <../../src/tanh_triad/mate.scad>
for(params=[[1.8,.13,.03],[.8,.32,0],[100,.49,.19],[.01,.01,.19]]) {
    shape=_cg_tanh_triad_shape(.8,34,params[0],params[1],params[2],720);
    mid=_cg_sample_polar_radii(shape[1],720,true);
    D=curve_gear_tanh_triad_centre_distance(.8,34,params[0],params[1],params[2],720);
    assert(D>max(mid),"Tanh distance intersects its driver");
    assert(abs(_cg_motion_closure_error_from_mid_radii(mid,D))<1e-6,"Tanh corrected bracket does not close");
}
cube(.01);
