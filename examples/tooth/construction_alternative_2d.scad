/***
 * @function construction_alternative_2d
 * @brief Tooth construction alternative: A coarse 12-position reference with a 10-degree pressure angle contrasts flank curvature and top closure with the standard 34-position, 20-degree tooth.
 * Source: [`tooth/construction_alternative_2d.scad`](tooth/construction_alternative_2d.scad)
 * A coarse 12-position reference with a 10-degree pressure angle contrasts flank curvature and top closure with the standard 34-position, 20-degree tooth.
 * @image ../images/tooth/construction_alternative_2d.png Tooth construction alternative
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
use <construction_2d.scad>;
include <../palette.scad>;
include <palette.scad>;
$fn=96;
_example_tooth_construction(modul=1.2,tooth_number=12,pressure_angle=10);
