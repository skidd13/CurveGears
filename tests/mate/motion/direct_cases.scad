/**
 * Direct conjugate-mate construction regression.
 *
 * The mate points are generated from driver-angle samples and the integrated
 * rolling increments.  No inverse motion-table lookup is involved.
 */
include <../../../src/mate/motion.scad>
include <../../../src/common/curve_gears_math.scad>
include <../../../src/mate/placement.scad>

n=240;
driver=[for(i=[0:n-1]) 10+2*cos(360*i/n)];
mid=[for(i=[0:n-1]) 10+2*cos(360*(i+.5)/n)];
D=_cg_solve_mate_distance(mid,12.01,40);
mate=_cg_mate_points_from_radius_samples(driver,mid,D);
motion=_cg_motion_table_from_radius_samples(driver,mid,D);
diagnostics=_cg_mate_pitch_diagnostics(driver,mid,D,mate);

assert(abs(motion[len(motion)-1][1]-360)<1e-6,"direct mate closure failed");
assert(min([for(i=[0:n-1]) abs(driver[i]+_cg_vlen(mate[i])-D)])<1e-6,"mate radii were not derived from D-driver radius");
assert(diagnostics[11][1],"direct mate diagnostics rejected a valid pitch curve");
assert(len(mate)==n,"direct mate sample count changed");

cube([.01,.01,.01]);
