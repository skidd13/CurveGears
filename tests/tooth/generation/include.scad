/***
 * @function tooth_generation_include
 * @brief Direct include smoke test for the standalone tooth-generation layer.
 * Source: [`tooth/generation/include.scad`](tooth/generation/include.scad)
 */
include <../../../src/tooth/generation.scad>

$fn=48;
modul=.8;
tooth_number=34;
candidate=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,20);
assert(candidate[0],str("standalone tooth generation failed: ",candidate[1]));
assert(len(candidate[8])>=6,"standalone tooth boundary is too short");
linear_extrude(height=4,convexity=4)
    polygon(candidate[8]);
