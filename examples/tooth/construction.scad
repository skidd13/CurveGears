/***
 * @function tooth_construction
 * @brief Tooth construction preview: Render one validated cached local tooth candidate.
 * Source: [`tooth/construction.scad`](tooth/construction.scad)
 *
 * This is the standalone output of tooth/generation.scad. It is intentionally
 * local rather than attached to a curve, so the involute flanks and top
 * closure can be inspected without placement hiding their shape.
 * @image ../images/tooth/construction.png Tooth construction preview preview
 */
include <../../src/common/curve_gears_math.scad>;

$fn=96;
modul=.8;
tooth_number=34;
pressure_angle=20;
candidate=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,pressure_angle);
assert(candidate[0],str("tooth construction failed: ",candidate[1]));

color("SteelBlue")
    linear_extrude(height=4,convexity=4)
        polygon(candidate[8]);
