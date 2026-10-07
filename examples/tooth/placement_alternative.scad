/***
 * @function placement_alternative
 * @brief Tooth placement alternative: A single high elliptical arch replaces the multi-period sinusoidal edge, exposing continuously changing normals and curvature.
 * Source: [`tooth/placement_alternative.scad`](tooth/placement_alternative.scad)
 * A single high elliptical arch replaces the multi-period sinusoidal edge, exposing continuously changing normals and curvature.
 * @image ../images/tooth/placement_alternative.png Tooth placement alternative
 * @image ../utils/doxydown-support/table-spacer.png ⠀
 */
use <placement.scad>;
include <../palette.scad>;
include <palette.scad>;
$fn=96;
_example_tooth_placement(modul=1.4,tooth_number=32,wave_height=18,curve="arc");
