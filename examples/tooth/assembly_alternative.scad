/***
 * @function assembly_alternative
 * @brief Tooth assembly alternative: An elongated ellipse replaces the circular pitch contour. Sixty tooth positions show body-to-flank splicing along changing curvature in the placed and assembled panels.
 * Source: [`tooth/assembly_alternative.scad`](tooth/assembly_alternative.scad)
 * An elongated ellipse replaces the circular pitch contour. Sixty tooth positions show body-to-flank splicing along changing curvature in the placed and assembled panels.
 * @image ../images/tooth/assembly_alternative.png Tooth assembly alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <assembly.scad>;
include <../palette.scad>;
include <palette.scad>;
$fn=96;
_example_tooth_assembly(modul=.6,tooth_number=60,samples=240,panel_offset=36,aspect=.45);
