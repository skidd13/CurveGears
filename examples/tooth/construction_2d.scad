/***
 * @function tooth_construction
 * @brief Tooth construction preview: Render one validated cached local tooth candidate in 2D.
 * Source: [`tooth/construction_2d.scad`](tooth/construction_2d.scad)
 *
 * This is the standalone output of tooth/generation.scad. It is intentionally
 * a 2D polygon rather than attached to a curve, so the involute flanks and top
 * closure can be inspected without placement hiding their shape.
 * @image ../images/tooth/construction_2d.png Tooth construction preview preview
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
include <../../src/common/curve_gears_math.scad>;
include <../palette.scad>;
include <palette.scad>;

$fn=96;
modul=.8;
tooth_number=34;
pressure_angle=20;
candidate=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,pressure_angle);
assert(candidate[0],str("tooth construction failed: ",candidate[1]));

color(example_tooth_color)
    polygon(candidate[8]);
